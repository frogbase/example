part of 'user.dart';

extension UserDBExt on User {
  Future<void> saveData() async =>
      await Boxes.users.put(appName.toCamelWord, this);

  Future<void> deleteData() async =>
      await Boxes.appSettings.delete(appName.toCamelWord);
}
