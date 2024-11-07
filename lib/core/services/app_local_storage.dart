// core/services/app_local_storage.dart
import 'package:hive/hive.dart';

class AppLocalStorage {
  static late Box userBox;
  static String nameKey = "nameKey";
  static String imageKey = "imageKey";
  static String isUpload = "isUploadKey";

  static init() {
    userBox = Hive.box('user');
  }

  static cachedData(String key, dynamic value) {
    userBox.put(key, value);
  }

  static getCachedData(String key) {
    return userBox.get(key);
  }
}
