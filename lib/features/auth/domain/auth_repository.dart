import 'package:mimine/features/auth/domain/entites/auth_entity.dart';
import 'package:mimine/features/auth/domain/entites/sign_up_data.dart';

abstract class AuthRepository {
  Future<AuthEntity> login(String email, String password);
  Future<AuthEntity> signUp(SignUpData signUpData);
  Future<AuthEntity> logout();
}
