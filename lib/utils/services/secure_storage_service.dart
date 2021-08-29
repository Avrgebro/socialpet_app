import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {


  static Future<String?> getValue(String key) async {
    return await FlutterSecureStorage().read(key: key);
  }

  static Future<void> setValue(String key, String value) async {
    await FlutterSecureStorage().write(key: key, value: value);
  }

  static Future<void> deleteValue(String key) async {
    await FlutterSecureStorage().delete(key: key);
  }

  static Future<void> clearStorage() async{
    await FlutterSecureStorage().deleteAll();
  }

}