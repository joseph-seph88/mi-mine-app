import 'package:equatable/equatable.dart';
import 'package:mimine/features/splash/presentation/enums/splash_status.dart';

class SplashState extends Equatable {
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final String? errorMessage;
  final SplashStatus splashStatus;

  const SplashState({
    this.isLoading = true,
    this.isError = false,
    this.isSuccess = false,
    this.errorMessage,
    this.splashStatus = SplashStatus.initial,
  });

  SplashState copyWith({
    bool? isLoading,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    SplashStatus? splashStatus,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      splashStatus: splashStatus ?? this.splashStatus,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, isError, isSuccess, errorMessage, splashStatus];
}
