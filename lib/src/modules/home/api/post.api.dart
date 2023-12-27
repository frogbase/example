import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../frogbase/model/api.response.dart';
import '../../../frogbase/utils/helpers.dart';
import '../../../shared/show_toast/awsome.snackbar/awesome.snackbar.dart';
import '../../../shared/show_toast/awsome.snackbar/show.awesome.snackbar.dart';
import '../../../utils/logger/logger_helper.dart';
import '../model/post.model.dart';

Future<List<Post>> getPostsApi([
  int page = 1,
  int limit = 50,
  String filter = '',
]) async {
  EasyLoading.show(status: 'Fetching posts...');
  try {
    //
    final response = await fb.apiRequest(
        'GET', 'posts?page=$page&limit=$limit&filter=$filter');
    final apiModel = ApiResponse.fromRawJson(response);
    if (!apiModel.success) {
      EasyLoading.showError(apiModel.message);
      return [];
    }
    List<Post> posts = [];
    for (final post in apiModel.data) {
      posts.add(Post.fromJson(post));
    }
    EasyLoading.dismiss();
    return posts;
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return [];
  } catch (e) {
    log.e('Posts Fetching: $e');
    EasyLoading.dismiss();
    return [];
  }
}

Future<void> dummyPostsCreteApi(BuildContext context) async {
  EasyLoading.show(status: 'Creating account...');
  const dummyPostCount = 100;
  try {
    //
    for (int i = 0; i < dummyPostCount; i++) {
      await fb.apiRequest(
        'POST',
        'posts',
        data: {
          'title':
              '${i + 1} - Lorem Ipsum - ${DateTime.now().millisecondsSinceEpoch}',
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
        },
      );
    }
    //
    if (!context.mounted) return;
    showAwesomeSnackbar(
        context,
        'Success!',
        'Dummy Post ($dummyPostCount) created successfully.',
        MessageType.success);
    return;
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return;
  } catch (e) {
    log.e('Post Creation: $e');
    if (!context.mounted) return;
    showAwesomeSnackbar(context, 'Failed!', e.toString(), MessageType.failure);
    return;
  }
}
