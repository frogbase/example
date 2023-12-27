import 'package:example/src/frogbase/model/auth.store.dart';
import 'package:example/src/frogbase/model/token.dart';
import 'package:hive/hive.dart';

import '../modules/auth/model/user.dart';
import '../modules/settings/model/currency/currency.model.dart';
import '../modules/settings/model/locale/locale.model.dart';
import '../modules/settings/model/settings.model.dart';
import '../modules/settings/model/theme/theme.model.dart';
import 'hive.dart';

class HiveFuntions {
  static void registerHiveAdepters() {
    Hive.registerAdapter(CurrencyProfileAdapter());
    Hive.registerAdapter(LocaleProfileAdapter());
    Hive.registerAdapter(ThemeProfileAdapter());
    Hive.registerAdapter(AppSettingsAdapter());
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(TokenAdapter());
    Hive.registerAdapter(AuthStoreAdapter());
  }

  static Future<void> openAllBoxes() async {
    await Hive.openBox<CurrencyProfile>(BoxNames.currencyProfile);
    await Hive.openBox<LocaleProfile>(BoxNames.localeProfile);
    await Hive.openBox<ThemeProfile>(BoxNames.themeProfile);
    await Hive.openBox<AppSettings>(BoxNames.appSettings);
    await Hive.openBox<User>(BoxNames.users);
    await Hive.openBox<Token>(BoxNames.tokens);
    await Hive.openBox<AuthStore>(BoxNames.authStores);
  }

  static Future<void> closeAllBoxes() async {
    await Boxes.currencyProfile.close();
    await Boxes.localeProfile.close();
    await Boxes.themeProfile.close();
    await Boxes.appSettings.close();
    await Boxes.users.close();
    await Boxes.tokens.close();
    await Boxes.authStores.close();
  }

  static Future<void> clearAllBoxes() async {
    await Boxes.currencyProfile.clear();
    await Boxes.localeProfile.clear();
    await Boxes.themeProfile.clear();
    await Boxes.appSettings.clear();
    await Boxes.users.clear();
    await Boxes.tokens.clear();
    await Boxes.authStores.clear();
  }

  static Future<void> deleteAllBoxes() async {
    await Hive.deleteBoxFromDisk(BoxNames.currencyProfile);
    await Hive.deleteBoxFromDisk(BoxNames.localeProfile);
    await Hive.deleteBoxFromDisk(BoxNames.themeProfile);
    await Hive.deleteBoxFromDisk(BoxNames.appSettings);
    await Hive.deleteBoxFromDisk(BoxNames.users);
    await Hive.deleteBoxFromDisk(BoxNames.tokens);
    await Hive.deleteBoxFromDisk(BoxNames.authStores);
  }
}
