import 'package:mimine/features/auth/domain/auth_repository.dart';
import 'package:mimine/features/auth/domain/entites/auth_entity.dart';

class LoginUsecase {
  final AuthRepository _authRepository;

  LoginUsecase(this._authRepository);

  Future<AuthEntity> call(String email, String password) async {
    return await _authRepository.login(email, password);
  }
}
