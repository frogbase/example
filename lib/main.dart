import 'package:beamer/beamer.dart';
import 'package:example/src/db/db.dart';
import 'package:flutter/material.dart' show runApp;
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart' show App;
import 'src/config/get.platform.dart';
import 'src/frogbase/frogbase.dart';
import 'src/frogbase/utils/helpers.dart';
import 'src/utils/themes/themes.dart';

const isProduction = false;

void main() async {
  await _init();
  runApp(const ProviderScope(child: App()));
  SystemChrome.setSystemUIOverlayStyle(uiConfig);
}

Future<void> _init() async {
  Beamer.setPathUrlStrategy();
  pt = PlatformInfo.getCurrentPlatformType();
  configLoading();
  await openDB();
  await initAppDatum();
  fb = Frogbase();
  await fb.init();
}

void configLoading() {
  EasyLoading.instance
    ..dismissOnTap = false
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle;
}
