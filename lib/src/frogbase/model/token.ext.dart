part of 'token.dart';

extension TokenExt on Token {
  Future<void> saveData() async =>
      await Boxes.tokens.put(appName.toCamelWord, this);

  Future<void> deleteData() async =>
      await Boxes.appSettings.delete(appName.toCamelWord);
}
