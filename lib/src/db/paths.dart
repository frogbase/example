import 'dart:io' show Directory;

import 'package:flutter/material.dart' show WidgetsFlutterBinding;
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

import '../config/constants.dart' show appName;
import '../config/get.platform.dart';
import '../utils/extensions/extensions.dart';
import '../utils/logger/logger_helper.dart';

final appDir = AppDir();

Future<void> initDir() async {
  if (pt.isWeb) return;
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  appDir.root = Directory(join(dir.path, '.${appName.toCamelWord}'));

  appDir.db = Directory(join(appDir.root.path, 'db'));
  appDir.files = Directory(join(appDir.root.path, 'files'));
  appDir.backup = Directory(join(appDir.root.path, 'backup'));
  if (!appDir.root.existsSync()) appDir.root.createSync(recursive: true);
  if (!appDir.db.existsSync()) appDir.db.createSync(recursive: true);
  if (!appDir.files.existsSync()) appDir.files.createSync(recursive: true);
  if (!appDir.backup.existsSync()) appDir.backup.createSync(recursive: true);
  log.i('App Directory: ${appDir.root.path}');
}

class AppDir {
  late Directory db;
  late Directory root;
  late Directory files;
  late Directory backup;
  AppDir();
}
