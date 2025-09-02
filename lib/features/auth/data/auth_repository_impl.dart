import 'package:mimine/common/models/user_response.dart';
import 'package:mimine/core/http/api_response.dart';
import 'package:mimine/features/auth/data/auth_datasource.dart';
import 'package:mimine/features/auth/data/models/sign_up_request.dart';
import 'package:mimine/features/auth/domain/auth_repository.dart';
import 'package:mimine/features/auth/domain/entites/sign_up_data.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _authDatasource;

  AuthRepositoryImpl(this._authDatasource);

  @override
  Future<ApiResponse<UserResponse>> login(String email, String password) async {
    return await _authDatasource.login(email, password);
  }

  @override
  Future<ApiResponse> signUp(SignUpData signUpData) async {
    final signUpRequest = SignUpRequest.fromSignUpData(signUpData);
    return await _authDatasource.signUp(signUpRequest);
  }

  @override
  Future<ApiResponse> logout() async {
    return await _authDatasource.logout();
  }
}
