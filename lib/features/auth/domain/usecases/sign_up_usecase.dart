import 'package:mimine/core/http/api_response.dart';
import 'package:mimine/features/auth/domain/auth_repository.dart';
import 'package:mimine/features/auth/domain/entites/sign_up_data.dart';

class SignUpUsecase {
  final AuthRepository _authRepository;

  SignUpUsecase(this._authRepository);

  Future<ApiResponse> call(SignUpData signUpData) async {
    return await _authRepository.signUp(signUpData);
  }
}
