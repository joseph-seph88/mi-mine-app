import 'dart:async';
import 'package:catching_josh/catching_josh.dart';
import 'package:dio/dio.dart';
import 'package:mimine/common/constants/api_path.dart';
import 'package:mimine/common/models/app_error.dart';
import 'package:mimine/core/services/local_token_service.dart';

class AuthInterceptor extends Interceptor {
  final LocalTokenService _tokenService;
  final Dio _dio;
  final Dio _refreshDio;

  AuthInterceptor(this._tokenService, this._dio, this._refreshDio);

  static bool _isRefreshing = false;
  static Completer<String>? _refreshCompleter;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (_shouldSkipAuth(options.path)) {
      return handler.next(options);
    }

    final StandardResult tokenResult = await _tokenService.getToken();

    if (tokenResult.data != null) {
      options.headers['Authorization'] = 'Bearer ${tokenResult.data}';
      return handler.next(options);
    } else {
      return handler.reject(DioException(
        requestOptions: options,
        type: DioExceptionType.unknown,
      ));
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldSkipAuth(err.requestOptions.path)) {
      return handler.next(err);
    }

    if (_isSessionExpired(err)) {
      await _handleInvalidateSession();
      return handler.next(err);
    }

    if (_isTokenExpired(err)) {
      if (_isRefreshing) {
        try {
          final newToken = await _refreshCompleter!.future;
          final newOptions = _buildNewOptions(err, newToken);
          return handler.resolve(await _dio.fetch(newOptions));
        } catch (e) {
          await _handleInvalidateSession();
          return handler.next(err);
        }
      }

      _isRefreshing = true;
      _refreshCompleter = Completer<String>();

      try {
        final refreshTokenResult = await _tokenService.getRefreshToken();

        if (refreshTokenResult.data != null) {
          try {
            final refreshToken = refreshTokenResult.data as String;
            final Dio refreshDio = _refreshDio;
            final newToken = await _getRefreshToken(refreshDio, refreshToken);

            await _tokenService.saveToken(newToken);
            _refreshCompleter!.complete(newToken);

            final newOptions = _buildNewOptions(err, newToken);
            return handler.resolve(await _dio.fetch(newOptions));
          } catch (e) {
            _refreshCompleter!.completeError(e);
            _resetRefreshState();
            await _handleInvalidateSession();
            return handler.next(err);
          }
        } else {
          _resetRefreshState();
          await _handleInvalidateSession();
          return handler.next(err);
        }
      } catch (e) {
        _resetRefreshState();
        await _handleInvalidateSession();
        return handler.next(err);
      }
    }
    return handler.next(err);
  }

  void _resetRefreshState() {
    _isRefreshing = false;
    _refreshCompleter = null;
  }

  bool _shouldSkipAuth(String path) {
    return path.startsWith(ApiPath.login) || path.startsWith(ApiPath.signUp);
  }

  bool _isSessionExpired(DioException err) {
    return (err.response?.statusCode == 401 ||
            err.response?.statusCode == 403) &&
        err.response?.data is Map &&
        ((err.response?.data as Map)['message'] == 'SESSION_EXPIRED' ||
            (err.response?.data as Map)['message'] == 'CONCURRENT_LOGIN');
  }

  bool _isTokenExpired(DioException err) {
    return err.response?.statusCode == 401 &&
        err.response?.data is Map &&
        (err.response?.data as Map)['message'] == 'TOKEN_EXPIRED';
  }

  RequestOptions _buildNewOptions(DioException err, String newToken) {
    return RequestOptions(
      method: err.requestOptions.method,
      path: err.requestOptions.path,
      baseUrl: err.requestOptions.baseUrl,
      headers: {
        ...err.requestOptions.headers,
        'Authorization': 'Bearer $newToken',
      },
      data: err.requestOptions.data,
      queryParameters: err.requestOptions.queryParameters,
    );
  }

  Future<void> _handleInvalidateSession() async {
    final Dio refreshDio = _refreshDio;
    // final response = await refreshDio.post(ApiPath.logout);

    final resposne =
        await joshReq(() => refreshDio.post(ApiPath.sessionInvalidate));

    final tokenResult = await _tokenService.deleteTokens();
    final isDeleted = tokenResult.data as bool;

    if (isDeleted) {
      JoshLogger.logResultSuccess(successTitle: '로컬 토큰 삭제 성공 :: $isDeleted');
      JoshLogger.logResponseSuccess(responseData: resposne);
    } else {
      JoshLogger.logResultError(
          errorMessage: '로컬 토큰 삭제 실패 :: ${tokenResult.errorMessage}');
      JoshLogger.logResponseError(responseData: resposne);
    }
  }

  Future<String> _getRefreshToken(Dio refreshDio, String refreshToken) async {
    final StandardResponse response = await joshReq(
      () => refreshDio.post(
        ApiPath.refresh,
        data: {'refreshToken': refreshToken},
      ),
    );

    if (response.data == null) {
      JoshLogger.logResponseError(
          errorMessage: 'Token refresh failed:: Response data is null');
      throw TokenError('Token refresh failed:: Response data is null');
    }

    if (response.data is! Map<String, dynamic>) {
      JoshLogger.logResponseError(
          errorMessage: 'Token refresh failed:: Invalid response format');
      throw TokenError('Token refresh failed:: Invalid response format');
    }

    final responseData = response.data as Map<String, dynamic>;
    final newToken = responseData['accessToken'] as String?;

    if (newToken == null || newToken.isEmpty) {
      JoshLogger.logResponseError(
          errorMessage:
              'Token refresh failed:: Access token not found in response');
      throw TokenError(
          'Token refresh failed:: Access token not found in response');
    }

    return newToken;
  }
}
