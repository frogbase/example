import 'dart:async';

import 'package:example/src/modules/home/api/post.api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../model/post.model.dart';

// typedef HomeNotifier = AutoDisposeAsyncNotifierProvider<HomeProvider, void>;

// final homeProvider = HomeNotifier(HomeProvider.new);

// class HomeProvider extends AutoDisposeAsyncNotifier<void> {
//   late List<Post> posts;
//   @override
//   FutureOr<void> build() async {
//     posts = [];
//     posts = await getPostsApi();
//   }

//   Future<void> refresh() async {
//     posts = await getPostsApi();
//     ref.notifyListeners();
//   }

  // Future<void> createDummyPosts(BuildContext context) async {
  //   await dummyPostsCreteApi(context);
  //   await refresh();
  // }
// }

typedef HomeNotifier = AsyncNotifierProvider<HomeProvider, void>;

final homeProvider = HomeNotifier(HomeProvider.new);

class HomeProvider extends AsyncNotifier<void> {
  int page = 1;
  bool isLoading = false;
  final refreshController = RefreshController(initialRefresh: false);

  List<Post> posts = [];

  @override
  FutureOr<void> build() async {
    posts = [...await getPostsApi(page)];
  }

  Future<void> loadMore() async {
    if (isLoading) return;
    isLoading = true;
    page++;
    final newPosts = await getPostsApi(page);
    posts = [...posts, ...newPosts];
    refreshController.loadComplete();
    isLoading = false;
    ref.notifyListeners();
  }

  Future<void> refresh() async {
    page = 0;
    final newPosts = await getPostsApi(page);
    posts = newPosts;
    refreshController.refreshCompleted();
    ref.notifyListeners();
  }

  Future<void> createDummyPosts(BuildContext context) async {
    await dummyPostsCreteApi(context);
    await refresh();
  }
}
