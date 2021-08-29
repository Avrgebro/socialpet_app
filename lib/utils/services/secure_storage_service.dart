import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {

  final FlutterSecureStorage _storage;

  SecureStorage({FlutterSecureStorage? storage})
    : _storage = storage ?? FlutterSecureStorage() ;

  Future<String?> getValue(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> setValue(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<void> deleteValue(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> cleanStorage() async{
    await _storage.deleteAll();
  }

}