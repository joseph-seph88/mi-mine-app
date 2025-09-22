import 'package:catching_josh/catching_josh.dart';
import 'package:mimine/common/constants/api_path.dart';
import 'package:mimine/core/infrastructure/network/api_client.dart';
import 'package:mimine/features/auth/data/models/sign_up_request.dart';

class AuthDatasource {
  final ApiClient _apiClient;
  AuthDatasource(this._apiClient);

  Future<StandardResponse> login(String email, String password) async {
    final response = await _apiClient.post(
      ApiPath.login,
      (json) => json,
      data: {'email': email, 'password': password},
    );

    if (response.isSuccess == true) {
      return response;
    } else {
      return StandardResponse(
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        isSuccess: response.isSuccess,
        data: response.data,
        dataType: response.dataType,
      );
    }
  }

  Future<StandardResponse> signUp(SignUpRequest request) async {
    final response = await _apiClient.post(
      ApiPath.signUp,
      (json) => json,
      data: request.toJson(),
    );

    if (response.isSuccess == true) {
      return response;
    } else {
      return StandardResponse(
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        isSuccess: response.isSuccess,
        data: response.data,
        dataType: response.dataType,
      );
    }
  }

  Future<StandardResponse> logout() async {
    final response = await _apiClient.post(
      ApiPath.logout,
      (json) => json,
    );

    if (response.isSuccess == true) {
      return response;
    } else {
      return StandardResponse(
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        isSuccess: response.isSuccess,
        data: response.data,
        dataType: response.dataType,
      );
    }
  }
}
