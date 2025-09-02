import 'package:mimine/core/http/api_response.dart';

class ApiResponseHelper {
  static bool isSuccess(ApiResponse response) {
    return response.data != null &&
        response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300;
  }

  static bool isFailure(ApiResponse response) {
    return !isSuccess(response);
  }

  static bool isEmpty(ApiResponse response) {
    return response.data == null || response.statusCode == null;
  }

  static bool isNotEmpty(ApiResponse response) {
    return !isEmpty(response);
  }
}
