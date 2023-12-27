import 'package:example/src/frogbase/model/auth.store.dart';
import 'package:example/src/frogbase/model/token.dart';
import 'package:hive/hive.dart' show Box, Hive;

import '../modules/auth/model/user.dart';
import '../modules/settings/model/currency/currency.model.dart';
import '../modules/settings/model/locale/locale.model.dart';
import '../modules/settings/model/settings.model.dart';
import '../modules/settings/model/theme/theme.model.dart';


class Boxes {
  static Box<CurrencyProfile> currencyProfile =  Hive.box<CurrencyProfile>(BoxNames.currencyProfile);
  static Box<LocaleProfile> localeProfile =  Hive.box<LocaleProfile>(BoxNames.localeProfile);
  static Box<ThemeProfile> themeProfile = Hive.box<ThemeProfile>(BoxNames.themeProfile);
  static Box<AppSettings> appSettings = Hive.box<AppSettings>(BoxNames.appSettings);
  static Box<User> users = Hive.box<User>(BoxNames.users);
  static Box<Token> tokens = Hive.box<Token>(BoxNames.tokens);
  static Box<AuthStore> authStores = Hive.box<AuthStore>(BoxNames.authStores);

  static Map<Box<dynamic>, dynamic Function(dynamic json)> get allBoxes => {
        currencyProfile: (json) => CurrencyProfile.fromJson(json),
        appSettings: (json) => AppSettings.fromJson(json),
        users: (json) => User.fromJson(json),
        tokens: (json) => json as String,
        authStores: (json) => json as String,
      };
}

class BoxNames {
  static const String currencyProfile = 'currencyProfile';
  static const String localeProfile = 'localeProfile';
  static const String themeProfile = 'themeProfile';
  static const String appSettings = 'appSettings';
  static const String users = 'users';
  static const String tokens = 'tokens';
  static const String authStores = 'authStores';

}

class HiveTypes {
  static const int currencyProfile = 0;
  static const int localeProfile = 1;
  static const int themeProfile = 2;
  static const int measurement = 3;
  static const int appSettings = 4;
  static const int user = 5;
  static const int token = 6;
  static const int authStore = 7;
}
