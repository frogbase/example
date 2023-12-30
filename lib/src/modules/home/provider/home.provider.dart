import 'dart:async';

import '../api/post.api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../model/post.model.dart';

typedef HomeNotifier = AsyncNotifierProvider<HomeProvider, void>;

final homeProvider = HomeNotifier(HomeProvider.new);

class HomeProvider extends AsyncNotifier<void> {
  int page = 1;
  bool isLoading = false;
  final refreshController = RefreshController(initialRefresh: false);
  final searchCntrlr = TextEditingController();

  List<Post> posts = [];

  @override
  FutureOr<void> build() async {
    _listener();
    posts = [...await getPostsApi(page: page, filter: searchCntrlr.text)];
  }

  _listener() => searchCntrlr.addListener(() async {
        page = 1;
        posts = await getPostsApi(page: page, filter: searchCntrlr.text);
        ref.notifyListeners();
      });

  Future<void> loadMore() async {
    if (isLoading) return;
    isLoading = true;
    page++;
    final newPosts = await getPostsApi(page: page, filter: searchCntrlr.text);
    posts = [...posts, ...newPosts];
    refreshController.loadComplete();
    isLoading = false;
    ref.notifyListeners();
  }

  Future<void> refresh() async {
    page = 0;
    final newPosts = await getPostsApi(page: page, filter: searchCntrlr.text);
    posts = newPosts;
    refreshController.refreshCompleted();
    ref.notifyListeners();
  }

  Future<void> createDummyPosts(BuildContext context) async {
    await dummyPostsCreteApi(context);
    await refresh();
  }
}
