import 'package:dio/dio.dart';
import 'package:mimine/core/infrastructure/config/env_config.dart';
import 'package:mimine/core/infrastructure/network/interceptors/auth_interceptor.dart';
import 'package:mimine/core/services/local_token_service.dart';

class DioFactory {
  final LocalTokenService _tokenService;
  final EnvConfig _envConfig;

  DioFactory(this._tokenService, this._envConfig);

  Dio createWithInterceptors() {
    final dio = _createDioInstance();
    _setupInterceptors(dio, createWithoutInterceptors());
    return dio;
  }

  Dio createWithoutInterceptors() {
    return _createDioInstance();
  }

  Dio _createDioInstance() {
    final serverUrl = _envConfig.serverUrl;
    final baseOptions = BaseOptions(
      baseUrl: serverUrl,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
    );
    return Dio(baseOptions);
  }

  void _setupInterceptors(Dio dio, Dio refreshDio) {
    dio.interceptors.add(AuthInterceptor(_tokenService, dio, refreshDio));
  }
}
