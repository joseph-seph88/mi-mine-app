import 'package:mimine/common/constants/api_path.dart';
import 'package:mimine/common/models/user_response.dart';
import 'package:mimine/core/infrastructure/network/api_client.dart';
import 'package:mimine/core/infrastructure/network/api_response.dart';
import 'package:mimine/features/auth/data/models/sign_up_request.dart';

class AuthDatasource {
  final ApiClient _apiClient;
  AuthDatasource(this._apiClient);

  Future<ApiResponse<UserResponse>> login(String email, String password) async {
    try {
      return await _apiClient.post(
        ApiPath.login,
        (json) => UserResponse.fromJson(json as Map<String, dynamic>),
        data: {'email': email, 'password': password},
      );
    } catch (e) {
      return ApiResponse<UserResponse>(
        statusCode: 208,
        statusMessage: 'Mock 로그인 성공 (서버 연결 실패)',
        data: UserResponse(
          id: 'mock_user_id',
          nickname: 'Mark2',
          email: email,
          accessToken: 'mock_access_token',
          refreshToken: 'mock_refresh_token',
        ),
      );
    }
  }

  Future<ApiResponse> signUp(SignUpRequest request) async {
    return await _apiClient.post(
      ApiPath.signUp,
      (json) => json,
      data: request.toJson(),
    );
  }

  Future<ApiResponse> logout() async {
    return await _apiClient.post(
      ApiPath.logout,
      (json) => json,
    );
  }
}
