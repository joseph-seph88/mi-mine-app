import 'package:catching_josh/catching_josh.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  Future<StandardResult> getString(String key) async {
    return await joshAsync(
      () => _storage.read(key: key),
      logTitle: '[SecureStorageService-getString]',
      showErrorLog: true,
      showSuccessLog: true,
    );
  }

  Future<StandardResult> setString(String key, String value) async {
    return await joshAsync(
      () => _storage.write(key: key, value: value),
      logTitle: '[SecureStorageService-setString]',
      showErrorLog: true,
      showSuccessLog: true,
    );
  }

  Future<StandardResult> remove(String key) async {
    return await joshAsync(
      () => _storage.delete(key: key),
      logTitle: '[SecureStorageService-remove]',
      showErrorLog: true,
      showSuccessLog: true,
    );
  }
}