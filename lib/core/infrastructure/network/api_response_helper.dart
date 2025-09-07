import 'package:catching_josh/catching_josh.dart';

class ApiResponseHelper {
  static bool isSuccess(StandardResponse response) {
    return response.data != null &&
        response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300;
  }

  static bool isFailure(StandardResponse response) {
    return !isSuccess(response);
  }

  static bool isEmpty(StandardResponse response) {
    return response.data == null || response.statusCode == null;
  }

  static bool isNotEmpty(StandardResponse response) {
    return !isEmpty(response);
  }
}
