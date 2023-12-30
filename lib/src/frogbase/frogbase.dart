import 'dart:convert';

import 'package:beamer/beamer.dart';
import 'utils/helpers.dart';
import '../utils/extensions/extensions.dart';
import 'package:http/http.dart' as http;

import '../config/constants.dart';
import '../db/hive.dart';
import '../utils/logger/logger_helper.dart';
import 'model/api.response.dart';
import 'model/auth.store.dart';
import 'model/token.dart';

late BeamerDelegate globalBeamDelegate;

class Frogbase {
  late AuthStore? authStore;

  Future<void> init() async {
    authStore = Boxes.authStores.get(appName.toCamelWord);
    log.f('AuthStore: $authStore');
    log.f('AuthStore: ${authStore?.isAccessTokenValid}');
    if (authStore != null && !authStore!.isRefreshTokenValid) {
      await signout();
      log.e('Automatically signed out due to invalid refresh token.');
    } else if (authStore != null && !authStore!.isAccessTokenValid) {
      log.i('Automatically refreshing access token.');
      await _refreshToken();
    }
    listenForAppConfig();
  }

  void listenForAppConfig() {
    Boxes.authStores
        .watch(key: appName.toCamelWord)
        .listen((_) => authStore = Boxes.authStores.get(appName.toCamelWord));
  }

  Future<void> signup({required Map<String, dynamic> data}) async {
    final response = await apiRequest(
      'POST',
      'auth/signup',
      data: data,
      isAuthRequired: false,
    );
    final apiModel = ApiResponse.fromRawJson(response);
    if (!apiModel.success) throw apiModel.message;
    authStore = AuthStore.fromRawJson(response);
    await authStore!.saveData();
  }

  Future<void> signin(String email, String password) async {
    final response = await apiRequest(
      'POST',
      'auth/signin',
      data: {
        'email': email,
        'password': password,
      },
      isAuthRequired: false,
    );
    final apiModel = ApiResponse.fromRawJson(response);
    if (!apiModel.success) throw apiModel.message;
    authStore = AuthStore.fromRawJson(response);
    await authStore!.saveData();
  }

  Future<void> signout() async {
    try {
      await authStore?.deleteData();
      authStore = null;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> get _token async {
    if (authStore == null) return null;
    if (authStore!.isAccessTokenValid) return authStore!.tokens.accessToken;
    return await _refreshToken();
  }

  Future<String?> _refreshToken() async {
    if (authStore == null) return null;
    if (!authStore!.isRefreshTokenValid) {
      await signout();
      globalBeamDelegate.update();
      return null;
    }
    final response = await apiRequest(
      'POST',
      'auth/regenerate-tokens',
      data: {'refresh-token': authStore!.tokens.refreshToken},
      isAuthRequired: false,
    );
    final apiModel = ApiResponse.fromRawJson(response);
    if (!apiModel.success) throw apiModel.message;
    authStore!.tokens = Token.fromJson(apiModel.data);
    log.i('New access tokens: ${authStore!.tokens}');
    await authStore!.save();
    return authStore!.tokens.accessToken;
  }

  Future<String> apiRequest(
    String method,
    String endPoint, {
    Map<String, dynamic>? data,
    bool isAuthRequired = true,
  }) async {
    final token = await _token;
    if (isAuthRequired && token == null) throw 'Session expired. Please sign in again.';
    final headers = {
      'Content-Type': 'application/json',
      if (isAuthRequired) 'Authorization': 'Bearer $token',
    };
    var request = http.Request(method, Uri.parse('$apiBaseUrl/$endPoint'));
    if (data != null) request.body = json.encode(data);
    request.headers.addAll(headers);

    final response = await request.send();
    final body = await response.stream.bytesToString();
    log.i('Response of $endPoint by $method: $body');
    return body;
  }

  Future<http.StreamedResponse> storeFile(List<String> paths) async {
    final headers = {'Authorization': 'Bearer $_token'};
    final request =
        http.MultipartRequest('POST', Uri.parse('$apiBaseUrl/file'));
    for (final path in paths) {
      request.files.add(await http.MultipartFile.fromPath('files', path));
    }
    request.headers.addAll(headers);

    return await request.send();
  }
}
