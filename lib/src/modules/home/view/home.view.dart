import 'package:example/app.routes.dart';
import 'package:example/src/config/constants.dart';
import 'package:example/src/db/db.dart';
import 'package:example/src/modules/home/provider/home.provider.dart';
import 'package:example/src/modules/settings/model/settings.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/is.need.zoom.adjust.dart';
import '../../../config/is.under.min.size.dart';
import '../../../config/screen_enlarge_warning.dart';
import '../../../config/zoom.level.adjust.dart';
import '../../../frogbase/utils/helpers.dart';
import '../../../localization/loalization.dart';
import '../../../utils/extensions/extensions.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    if (isUnderMinSize(context.mq.size)) return const ScreenEnlargeWarning();
    if (isNeedZoomAdjust(context)) return const ZoomLevelAdjustWarning();
    return Scaffold(
        appBar: const KAppBar(),
        body: const Body(),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () => context.beamPush(AppRoutes.settingsRoute),
          child: const Icon(Icons.settings, size: 20.0),
        ));
  }
}

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(t.appTitle),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () async =>
              await fb.signout().then((_) => context.beamUpdate()),
          icon: const Icon(Icons.logout, size: 20.0),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class Body extends ConsumerWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(homeProvider).when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('$error')),
        data: (_) {
          final notifier = ref.read(homeProvider.notifier);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => notifier.refresh(),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Refresh'),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => notifier.createDummyPosts(context),
                        icon: const Icon(Icons.add),
                        label: const Text('Add 100 Posts'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Total Posts: ${notifier.posts.length}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                ),
                Expanded(
                  child: notifier.posts.isEmpty
                      ? const Center(child: Text('No posts found'))
                      : SmartRefresher(
                          controller: notifier.refreshController,
                          enablePullUp: true,
                          onRefresh: notifier.refresh,
                          onLoading: notifier.loadMore,
                          child: CustomScrollView(
                            slivers: [
                              SliverFixedExtentList(
                                itemExtent: 78.0,
                                delegate: SliverChildBuilderDelegate(
                                  childCount: notifier.posts.length,
                                  (_, idx) {
                                    final post = notifier.posts[idx];
                                    return Card(
                                      elevation: 2.0,
                                      margin: const EdgeInsets.fromLTRB(
                                          6.0, 6.0, 6.0, 2.0),
                                      shape: roundedRectangleBorder5,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7.0, vertical: 5.0),
                                        child: Row(
                                          crossAxisAlignment: crossStart,
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Column(
                                                mainAxisSize: mainMin,
                                                crossAxisAlignment: crossStart,
                                                children: [
                                                  Text(
                                                    post.title,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        context.text.titleSmall,
                                                  ),
                                                  const SizedBox(height: 3.0),
                                                  Text(
                                                    post.description,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        context.text.labelSmall,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 3.0),
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                mainAxisSize: mainMin,
                                                crossAxisAlignment: crossEnd,
                                                children: [
                                                  Text(
                                                    appSettings
                                                        .getDateTimeFormat
                                                        .format(post.created),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: context
                                                        .text.labelMedium,
                                                  ),
                                                  Text(
                                                    post.creator.username,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: context
                                                        .text.labelMedium,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          );
        });
  }
}
