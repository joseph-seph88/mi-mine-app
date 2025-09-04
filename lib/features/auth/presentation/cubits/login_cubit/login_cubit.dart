import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/common/events/app_events.dart';
import 'package:mimine/common/events/event_bus.dart';
import 'package:mimine/core/infrastructure/network/api_response_helper.dart';
import 'package:mimine/core/utils/validators/form_validators.dart';
import 'package:mimine/features/auth/domain/usecases/login_usecase.dart';
import 'package:mimine/features/auth/presentation/cubits/login_cubit/login_state.dart';
import 'package:mimine/features/auth/presentation/enums/login_status.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase _loginUsecase;
  StreamSubscription? _appResumedSubscription;

  LoginCubit(this._loginUsecase) : super(LoginState()) {
    _initEventListeners();
  }

  void _initEventListeners() {
    _appResumedSubscription = eventBus.on<AppResumedEvent>().listen((_) {
      onAppResumed();
    });
  }

  Future<void> onAppResumed() async {
    // TODO: 세션 체크 로직 구현
    // final isSessionValid = await _checkSession();
    // if (!isSessionValid) {
    //   // 로그아웃 처리
    // }
  }

  @override
  Future<void> close() {
    _appResumedSubscription?.cancel();
    return super.close();
  }

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

    if (ApiResponseHelper.isSuccess(response)) {
      emit(state.copyWith(
        status: LoginStatus.success,
        userInfo: response.data,
      ));
    } else {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: response.statusMessage ?? 'Login failed',
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
