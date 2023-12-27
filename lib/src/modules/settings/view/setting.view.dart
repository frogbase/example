import 'package:flutter/material.dart';

import '../../../config/constants.dart';
import '../../../localization/loalization.dart';
import '../../../utils/extensions/extensions.dart';
import 'advance/admin.panel.tile.dart';
import 'advance/db.delete.tile.dart';
import 'advance/db.view.tile.dart';
import 'advance/performance.overlay.tile.dart';
import 'advance/url.config.tile.dart';
import 'basic/about.tile.dart';
import 'basic/date.formate.tile.dart';
import 'basic/font.tile.dart';
import 'basic/locale.tile.dart';
import 'basic/signout.tile.dart';
import 'basic/theme.tile.dart';
import 'basic/time.formate.tile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.beamBack(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20.0),
        ),
        title: Text(t.settings),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (_, __) => [
                SliverToBoxAdapter(
                  child: TabBar(
                    splashBorderRadius: borderRadius30,
                    isScrollable: true,
                    physics: const BouncingScrollPhysics(),
                    labelStyle: context.theme.textTheme.labelLarge,
                    tabs: [Tab(text: t.basic), Tab(text: t.advanced)],
                  ),
                ),
              ],
              body: const TabBarView(children: [BasicPart(), AdvancePart()]),
            ),
          ),
        ),
      ),
    );
  }
}

class BasicPart extends StatelessWidget {
  const BasicPart({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          ThemeTile(),
          LocaleTile(),
          DateFormatTile(),
          TimeFormatTile(),
          FontTile(),
          SignoutTile(),
          AboutTile(),
        ],
      ),
    );
  }
}

class AdvancePart extends StatelessWidget {
  const AdvancePart({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          PerformanceOverlayTile(),
          URLConfigTile(),
          AdminPanelTile(),
          DBViewTile(),
          DBDeleteTile(),
        ],
      ),
    );
  }
}
