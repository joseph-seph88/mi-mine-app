import 'package:equatable/equatable.dart';
import 'package:mimine/common/enums/location_permission_status.dart';
import 'package:mimine/features/splash/presentation/enums/splash_status.dart';

class SplashState extends Equatable {
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final String? errorMessage;
  final LocationPermissionStatus locationPermissionStatus;
  final SplashStatus splashStatus;

  const SplashState({
    this.isLoading = true,
    this.isError = false,
    this.isSuccess = false,
    this.errorMessage,
    this.locationPermissionStatus = LocationPermissionStatus.initial,
    this.splashStatus = SplashStatus.initial,
  });

  SplashState copyWith({
    bool? isLoading,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    LocationPermissionStatus? locationPermissionStatus,
    SplashStatus? splashStatus,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      locationPermissionStatus:
          locationPermissionStatus ?? this.locationPermissionStatus,
      splashStatus: splashStatus ?? this.splashStatus,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, isError, isSuccess, errorMessage, locationPermissionStatus, splashStatus];
}
