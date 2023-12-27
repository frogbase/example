class AppRoutes {
  ///
  /// isMaintenanceBreak is a global variable that is set to true when the app
  static const isMaintenanceBreak = false;

  ///
  static const String homeRoute = '/home';
  static const String authRoute = '/auth';
  static const String settingsRoute = '/settings';
  static const String maintenanceBreakRoute = '/maintenance-break';
  static const String serverDisconnectedRoute = '/server-disconnected';

  static const List<String> allRoutes = [
    homeRoute,
    authRoute,
    settingsRoute,
  ];

  static final List<String> allAuthRequiredRoutes = [...allRoutes]
    ..remove(authRoute);
}
