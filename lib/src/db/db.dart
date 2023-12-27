import 'package:hive_flutter/hive_flutter.dart';

import '../config/constants.dart';
import '../config/get.platform.dart';
import '../modules/settings/model/settings.model.dart';
import '../utils/extensions/extensions.dart';
import '../utils/logger/logger_helper.dart';
import 'db.functions.dart';
import 'hive.dart';
import 'paths.dart' show appDir, initDir;

late AppSettings appSettings;

Future<void> openDB() async {
  await initDir();
  await initHiveDB();
}

Future<void> initHiveDB() async {
  await Hive.initFlutter(pt.isWeb ? null : appDir.db.path);
  HiveFuntions.registerHiveAdepters();
  await HiveFuntions.openAllBoxes();
}

Future<void> initAppDatum() async {
  if (Boxes.appSettings.isEmpty) await appSettingsInit();
  appSettings = Boxes.appSettings.get(appName.toCamelWord) ?? AppSettings();
  log.i('App Initiated with appSettings: ${appSettings.firstRunDateTime}');
  listenForAppConfig();
}

Future<void> appSettingsInit() async {
  final appSettings = AppSettings();
  log.i(
      'First time App Settings Initiated with ${appSettings.firstRunDateTime}');
  await appSettings.saveData();
}

void listenForAppConfig() {
  Boxes.appSettings.watch(key: appName.toCamelWord).listen((_) => appSettings =
      Boxes.appSettings.get(appName.toCamelWord) ?? AppSettings());
}
