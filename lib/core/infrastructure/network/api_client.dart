import 'package:catching_josh/catching_josh.dart';
import 'package:dio/dio.dart';
import 'package:mimine/core/infrastructure/network/api_response.dart';

class ApiClient {
  final Dio _dio;
  ApiClient(this._dio);

  Future<ApiResponse<T>> get<T>(
    String path,
    T Function(dynamic) fromJson, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final responseData = await joshReq(() async {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    });

    return ApiResponse.fromJson(response: responseData, fromJson: fromJson);
  }

  Future<ApiResponse<T>> post<T>(
    String path,
    T Function(dynamic) fromJson, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final responseData = await joshReq(() async {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    });

    return ApiResponse.fromJson(response: responseData, fromJson: fromJson);
  }

  Future<ApiResponse<T>> put<T>(
    String path,
    T Function(dynamic) fromJson, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final responseData = await joshReq(() async {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    });

    return ApiResponse.fromJson(response: responseData, fromJson: fromJson);
  }

  Future<ApiResponse<T>> patch<T>(
    String path,
    T Function(dynamic) fromJson, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final responseData = await joshReq(() async {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    });

    return ApiResponse.fromJson(response: responseData, fromJson: fromJson);
  }

  Future<ApiResponse<T>> delete<T>(
    String path,
    T Function(dynamic) fromJson, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final responseData = await joshReq(() async {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    });

    return ApiResponse.fromJson(response: responseData, fromJson: fromJson);
  }
}
