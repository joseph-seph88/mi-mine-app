import 'package:catching_josh/catching_josh.dart';
import 'package:mimine/core/infrastructure/storage/secure_storage_service.dart';
import 'package:mimine/core/infrastructure/config/env_config.dart';

class LocalTokenService {
  final SecureStorageService _secureStorage;
  final String _authTokenKey;
  final String _refreshTokenKey;

  LocalTokenService(this._secureStorage, EnvConfig envConfig)
      : _authTokenKey = envConfig.authTokenKey,
        _refreshTokenKey = envConfig.refreshTokenKey;

  Future<StandardResult> getToken() async {
    return await _secureStorage.getString(_authTokenKey);
  }

  Future<StandardResult> saveToken(String token) async {
    return await _secureStorage.setString(_authTokenKey, token);
  }

  /// JoshAsync에서 - ErrorMessage가 사용자 Custom이 아니라 내부에서 발생한 에러 메시지를 담도록 변경 필요
  Future<StandardResult> deleteTokens() async {
    final authResult = await _secureStorage.remove(_authTokenKey);
    final refreshResult = await _secureStorage.remove(_refreshTokenKey);

    if (authResult.errorMessage == null && refreshResult.errorMessage == null) {
      return StandardResult(
        data: true,
        dataType: 'bool',
        errorMessage: null,
      );
    } else {
      return StandardResult(
        data: false,
        dataType: 'bool',
        errorMessage:
            'Failed to delete tokens: ${authResult.errorMessage ?? refreshResult.errorMessage}',
      );
    }
  }

  Future<StandardResult> getRefreshToken() async {
    return await _secureStorage.getString(_refreshTokenKey);
  }

  Future<StandardResult> saveRefreshToken(String token) async {
    return await _secureStorage.setString(_refreshTokenKey, token);
  }
}
