import 'package:catching_josh/catching_josh.dart';

class ApiResponse<T> {
  final int? statusCode;
  final String? statusMessage;
  final T? data;
  final String? dataType;

  ApiResponse({
    this.statusCode,
    this.statusMessage,
    this.data,
    this.dataType,
  });

  factory ApiResponse.fromJson({
    required StandardResponse response,
    required T Function(dynamic) fromJson,
  }) {
    return ApiResponse(
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      data: fromJson(response.data),
      dataType: response.dataType,
    );
  }
}
