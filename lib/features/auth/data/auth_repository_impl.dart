
import 'package:mimine/features/auth/data/auth_datasource.dart';
import 'package:mimine/features/auth/data/models/sign_up_request.dart';
import 'package:mimine/features/auth/domain/auth_repository.dart';
import 'package:mimine/features/auth/domain/entites/auth_entity.dart';
import 'package:mimine/features/auth/domain/entites/sign_up_data.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _authDatasource;

  AuthRepositoryImpl(this._authDatasource);

  @override
  Future<AuthEntity> login(String email, String password) async {
    final response = await _authDatasource.login(email, password);
    return AuthEntity.fromJson(response);
  }

  @override
  Future<AuthEntity> signUp(SignUpData signUpData) async {
    final signUpRequest = SignUpRequest.fromSignUpData(signUpData);
    final response = await _authDatasource.signUp(signUpRequest);
    return AuthEntity.fromJson(response);
  }

  @override
  Future<AuthEntity> logout() async {
    final response = await _authDatasource.logout();
    return AuthEntity.fromJson(response);
  }
}
