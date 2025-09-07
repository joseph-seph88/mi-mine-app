import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/core/utils/validators/form_validators.dart';
import 'package:mimine/features/auth/domain/usecases/login_usecase.dart';
import 'package:mimine/features/auth/presentation/cubits/login_cubit/login_state.dart';
import 'package:mimine/features/auth/presentation/enums/login_status.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase _loginUsecase;

  LoginCubit(this._loginUsecase) : super(LoginState());

  Future<void> onAppResumed() async {}

  Future<void> login(String email, String password) async {
    final emailError = FormValidators.email(email);
    final passwordError = FormValidators.password(password);

    if (emailError != null || passwordError != null) {
      emit(state.copyWith(
        email: email,
        password: password,
        emailError: emailError,
        passwordError: passwordError,
      ));
      return;
    }

    emit(state.copyWith(
      status: LoginStatus.inProgress,
      email: email,
      password: password,
      emailError: null,
      passwordError: null,
      errorMessage: null,
    ));

    final response = await _loginUsecase.call(email, password);

    if (response.isSuccess) {
      emit(state.copyWith(
        status: LoginStatus.success,
        userInfo: response,
      ));
    } else {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: response.errorMessage ?? 'Login failed',
      ));
    }
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void resetState() {
    emit(const LoginState());
  }
}
