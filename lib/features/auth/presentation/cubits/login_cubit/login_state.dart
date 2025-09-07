import 'package:equatable/equatable.dart';
import 'package:mimine/features/auth/domain/entites/auth_entity.dart';
import 'package:mimine/features/auth/presentation/enums/login_status.dart';

class LoginState extends Equatable {
  final String email;
  final String? emailError;
  final String password;
  final String? passwordError;

  final bool isPasswordVisible;

  final LoginStatus status;
  final String? errorMessage;
  final AuthEntity? userInfo;

  const LoginState({
    this.email = '',
    this.emailError,
    this.password = '',
    this.passwordError,
    this.isPasswordVisible = false,
    this.status = LoginStatus.initial,
    this.errorMessage,
    this.userInfo,
  });

  LoginState copyWith({
    String? email,
    String? emailError,
    String? password,
    String? passwordError,
    LoginStatus? status,
    String? errorMessage,
    bool? isPasswordVisible,
    AuthEntity? userInfo,
  }) {
    return LoginState(
      email: email ?? this.email,
      emailError: emailError ?? this.emailError,
      password: password ?? this.password,
      passwordError: passwordError ?? this.passwordError,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      userInfo: userInfo ?? this.userInfo,
    );
  }

  @override
  List<Object?> get props => [
        email,
        emailError,
        password,
        passwordError,
        isPasswordVisible,
        status,
        errorMessage,
        userInfo,
      ];
}
