import 'dart:io';

import 'package:flutter/material.dart';

import '../../../db/db.functions.dart';
import '../../../db/paths.dart';

Future<void> deleteDB() async {
  debugPrint('Deleting Database : ${appDir.db}');
  await HiveFuntions.closeAllBoxes();
  await HiveFuntions.deleteAllBoxes();
  await appDir.root.delete(recursive: true);
  exit(0);
}
