part of 'auth.store.dart';

extension AuthStoreExt on AuthStore {
  Future<void> saveData() async =>
      await Boxes.authStores.put(appName.toCamelWord, this);

  Future<void> deleteData() async =>
      await Boxes.authStores.delete(appName.toCamelWord);
  
}
