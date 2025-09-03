import 'package:mimine/common/models/user_response.dart';
import 'package:mimine/core/infrastructure/network/api_response.dart';
import 'package:mimine/features/auth/domain/auth_repository.dart';

class LoginUsecase {
  final AuthRepository _authRepository;

  LoginUsecase(this._authRepository);

  Future<ApiResponse<UserResponse>> call(String email, String password) async {
    return await _authRepository.login(email, password);
  }
}
