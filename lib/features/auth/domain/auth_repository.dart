import 'package:mimine/common/models/user_response.dart';
import 'package:mimine/core/http/api_response.dart';
import 'package:mimine/features/auth/domain/entites/sign_up_data.dart';

abstract class AuthRepository {
  Future<ApiResponse<UserResponse>> login(String email, String password);
  Future<ApiResponse> signUp(SignUpData signUpData);
  Future<ApiResponse> logout();
}
