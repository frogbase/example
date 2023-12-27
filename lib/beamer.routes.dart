import 'package:beamer/beamer.dart'
    show
        BeamGuard,
        BeamPage,
        BeamPageType,
        BeamerDelegate,
        RoutesLocationBuilder;
import 'package:example/src/frogbase/utils/helpers.dart';
import 'package:example/src/modules/auth/view/auth.dart';
import 'package:example/src/modules/settings/view/setting.view.dart';
import 'package:flutter/widgets.dart' show ValueKey;

import 'app.routes.dart';
import 'src/config/constants.dart';
import 'src/modules/home/view/home.view.dart';
import 'src/modules/maintenance.break/maintenance.break.dart';
import 'src/shared/page_not_found/page_not_found.dart';

final routerDelegate = BeamerDelegate(
  initialPath: AppRoutes.homeRoute,
  notFoundPage: const BeamPage(
    key: ValueKey('not-found'),
    title: 'Page not found - $appName',
    child: KPageNotFound(error: '404 - Page not found!'),
  ),
  locationBuilder: RoutesLocationBuilder(
    routes: {
      AppRoutes.homeRoute: (_, __, ___) {
        return const BeamPage(
          key: ValueKey(AppRoutes.homeRoute),
          title: appName,
          type: BeamPageType.fadeTransition,
          child: HomeView(),
        );
      },
      AppRoutes.authRoute: (_, __, ___) {
        return const BeamPage(
          key: ValueKey(AppRoutes.authRoute),
          title: '$appName - Auth',
          type: BeamPageType.fadeTransition,
          child: AuthView(),
        );
      },
      AppRoutes.settingsRoute: (_, __, ___) {
        return const BeamPage(
          key: ValueKey(AppRoutes.settingsRoute),
          title: '$appName - Settings',
          type: BeamPageType.fadeTransition,
          child: SettingsView(),
        );
      },
      AppRoutes.maintenanceBreakRoute: (_, __, ___) {
        return const BeamPage(
          key: ValueKey(AppRoutes.maintenanceBreakRoute),
          title: '$appName - Maintenance break',
          type: BeamPageType.fadeTransition,
          child: MaintenanceBreak(),
        );
      },
      AppRoutes.serverDisconnectedRoute: (_, __, ___) {
        return const BeamPage(
          key: ValueKey(AppRoutes.serverDisconnectedRoute),
          title: '$appName - Server disconnected',
          type: BeamPageType.fadeTransition,
          child: KServerNotRunning(),
        );
      },
    },
  ).call,
  guards: [
    BeamGuard(
      pathPatterns: AppRoutes.allRoutes,
      check: (_, __) => !AppRoutes.isMaintenanceBreak,
      beamToNamed: (_, __, ___) => AppRoutes.maintenanceBreakRoute,
    ),
    BeamGuard(
      pathPatterns: [AppRoutes.maintenanceBreakRoute],
      check: (_, __) => AppRoutes.isMaintenanceBreak,
      beamToNamed: (_, __, ___) => AppRoutes.homeRoute,
    ),
    // BeamGuard(
    //   pathPatterns: AppRoutes.allRoutes,
    //   check: (_, __) => isServerRunning,
    //   beamToNamed: (_, __, ___) => AppRoutes.serverDisconnectedRoute,
    // ),
    // BeamGuard(
    //   pathPatterns: [AppRoutes.serverDisconnectedRoute],
    //   check: (_, __) => !isServerRunning,
    //   beamToNamed: (_, __, ___) => AppRoutes.homeRoute,
    // ),
    BeamGuard(
      pathPatterns: AppRoutes.allAuthRequiredRoutes,
      check: (_, __) => fb.authStore?.isAccessTokenValid ?? false,
      beamToNamed: (_, __, ___) => AppRoutes.authRoute,
    ),
    BeamGuard(
      pathPatterns: [AppRoutes.authRoute],
      check: (_, __) => !(fb.authStore?.isAccessTokenValid ?? false),
      beamToNamed: (_, __, ___) => AppRoutes.homeRoute,
    ),
  ],
);
