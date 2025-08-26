import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthFormState extends AuthState {
  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
  final bool isPasswordVisible;
  final AuthStatus status;

  const AuthFormState({
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
    this.isPasswordVisible = false,
    this.status = AuthStatus.initial,
  });

  AuthFormState copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
    bool? isPasswordVisible,
    AuthStatus? status,
  }) {
    return AuthFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props =>
      [email, password, emailError, passwordError, isPasswordVisible, status];
}

enum AuthStatus {
  initial,
  loading,
  success,
  failed,
}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthFailedState extends AuthState {
  final String errorMessage;

  const AuthFailedState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
