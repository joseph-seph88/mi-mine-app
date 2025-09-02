import 'package:catching_josh/catching_josh.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mimine/core/configs/env_config.dart';

class TokenManager {
  final FlutterSecureStorage _storage;
  final String _authTokenKey;
  final String _refreshTokenKey;

  TokenManager(this._storage, EnvConfig envConfig)
      : _authTokenKey = envConfig.authTokenKey,
        _refreshTokenKey = envConfig.refreshTokenKey;

  Future<StandardResult> getToken() async {
    return await joshAsync(
      () => _storage.read(key: _authTokenKey),
      logTitle: '[TokenManager-getToken]',
      showErrorLog: true,
      showSuccessLog: true,
    );
  }

  Future<StandardResult> saveToken(String token) async {
    return await joshAsync(
      () async {
        _storage.write(key: _authTokenKey, value: token);
        return true;
      },
      logTitle: '[TokenManager-saveToken]',
      showErrorLog: true,
      showSuccessLog: true,
    );
  }

  Future<StandardResult> deleteTokens() async {
    return await joshAsync(
      () async {
        _storage.delete(key: _authTokenKey);
        _storage.delete(key: _refreshTokenKey);
        return true;
      },
      logTitle: '[TokenManager-deleteTokens]',
      showErrorLog: true,
      showSuccessLog: true,
    );
  }

  Future<StandardResult> getRefreshToken() async {
    return await joshAsync(
      () => _storage.read(key: _refreshTokenKey),
      logTitle: '[TokenManager-getRefreshToken]',
      showErrorLog: true,
      showSuccessLog: true,
    );
  }

  Future<StandardResult> saveRefreshToken(String token) async {
    return await joshAsync(
      () async {
        _storage.write(key: _refreshTokenKey, value: token);
        return true;
      },
      logTitle: '[TokenManager-saveRefreshToken]',
      showErrorLog: true,
      showSuccessLog: true,
    );
  }
}
