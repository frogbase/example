import 'dart:convert' show base64, base64Decode, json, jsonDecode, utf8;

import '../../db/hive.dart';
import 'token.dart';
import '../../modules/auth/model/user.dart';
import '../../utils/extensions/extensions.dart';
import 'package:hive/hive.dart';

import '../../config/constants.dart';

part 'auth.store.ext.dart';
part 'auth.store.g.dart';

@HiveType(typeId: HiveTypes.authStore)
class AuthStore extends HiveObject {
  @HiveField(0)
  User user;
  @HiveField(1)
  Token tokens;

  AuthStore({
    required this.user,
    required this.tokens,
  });

  factory AuthStore.fromJson(Map<String, dynamic> json) => AuthStore(
        user: User.fromJson(json[_Json.data] as Map<String, dynamic>),
        tokens: Token.fromJson(json[_Json.tokens] as Map<String, dynamic>),
      );

  factory AuthStore.fromRawJson(String source) =>
      AuthStore.fromJson(json.decode(source));

  // to json
  Map<String, dynamic> toJson() => {
        _Json.data: user.toJson(),
        _Json.tokens: tokens.toJson(),
      };

  String toRawJson() => json.encode(toJson());

  @override
  String toString() => 'AuthStore{user: $user, tokens: $tokens}';

  bool get isAccessTokenValid => _isValid(tokens.accessToken);
  bool get isRefreshTokenValid => _isValid(tokens.refreshToken);

  bool _isValid(String token) {
    final parts = token.split('.');
    if (parts.length != 3) return false;

    final tokenPart = base64.normalize(parts[1]);
    final data = jsonDecode(utf8.decode(base64Decode(tokenPart)))
        as Map<String, dynamic>;

    final exp = data['exp'] is int
        ? data['exp'] as int
        : (int.tryParse(data['exp'].toString()) ?? 0);

    return exp > (DateTime.now().millisecondsSinceEpoch / 1000);
  }
}

class _Json {
  static const data = 'data';
  static const tokens = 'tokens';
}
