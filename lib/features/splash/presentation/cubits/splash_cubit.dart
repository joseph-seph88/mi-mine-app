import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/features/splash/presentation/cubits/splash_state.dart';
import 'package:mimine/features/splash/presentation/enums/splash_status.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  Future<void> checkSession() async {
    emit(state.copyWith(splashStatus: SplashStatus.success, isLoading: false));
  }

  Future<void> checkFailure() async {
    emit(state.copyWith(splashStatus: SplashStatus.failure, isLoading: false));
  }

  // final CheckSessionUsecase _sessionCheckUsecase;
  // final LocationUseCase _locationUseCase;

  // SplashCubit(this._sessionCheckUsecase, this._locationUseCase)
  //     : super(const SplashState());

  // void stopLoading() {
  //   emit(state.copyWith(isLoading: false));
  // }

  // Future<void> checkSession() async {
  //   final result = await _sessionCheckUsecase.call();

  //   result.fold(
  //     (error) => emit(state.copyWith(
  //       isLoading: false,
  //       isError: true,
  //       errorMessage: error.message,
  //     )),
  //     (session) => emit(state.copyWith(
  //       isLoading: false,
  //       isSuccess: true,
  //     )),
  //   );
  // }

  // Future<void> checkLocationPermission() async {
  //   try {
  //     // 1단계: 기기 위치 서비스 확인
  //     final isLocationEnabledResult =
  //         await _locationUseCase.checkLocationService();
  //     final isLocationEnabled = isLocationEnabledResult.fold(
  //       (error) => false,
  //       (enabled) => enabled,
  //     );
  //     logger.d("체크로케이션서비스 :: $isLocationEnabled");
  //     if (!isLocationEnabled) {
  //       emit(state.copyWith(
  //           locationPermissionStatus:
  //               LocationPermissionStatus.serviceDisabled));
  //       return;
  //     }

  //     // 2단계: 현재 앱 권한 상태 확인
  //     final currentPermissionResult = await _locationUseCase.checkPermission();
  //     logger.d("체크퍼미션 :: $currentPermissionResult");

  //     // 3단계: 권한 상태만 확인하고 변경
  //     currentPermissionResult.fold(
  //       (error) {
  //         emit(state.copyWith(
  //           locationPermissionStatus: LocationPermissionStatus.permissionError,
  //           errorMessage: error.message,
  //         ));
  //       },
  //       (currentPermission) {
  //         switch (currentPermission) {
  //           case LocationPermission.denied:
  //             emit(state.copyWith(
  //                 locationPermissionStatus:
  //                     LocationPermissionStatus.permissionDenied));
  //             break;
  //           case LocationPermission.deniedForever:
  //             emit(state.copyWith(
  //                 locationPermissionStatus:
  //                     LocationPermissionStatus.permissionPermanentlyDenied));
  //             break;
  //           case LocationPermission.whileInUse:
  //           case LocationPermission.always:
  //             emit(state.copyWith(
  //                 locationPermissionStatus:
  //                     LocationPermissionStatus.permissionGranted));
  //             break;
  //           default:
  //             emit(state.copyWith(
  //                 locationPermissionStatus:
  //                     LocationPermissionStatus.permissionUnknown));
  //             break;
  //         }
  //       },
  //     );
  //   } catch (e) {
  //     emit(state.copyWith(
  //         locationPermissionStatus: LocationPermissionStatus.permissionError,
  //         errorMessage: e.toString()));
  //   }
  // }

  // Future<void> requestLocationPermission() async {
  //   try {
  //     final result = await _locationUseCase.requestPermission();
  //     result.fold(
  //       (error) {
  //         emit(state.copyWith(
  //           locationPermissionStatus: LocationPermissionStatus.permissionError,
  //           errorMessage: error.message,
  //         ));
  //       },
  //       (permission) {
  //         if (permission == LocationPermission.denied) {
  //           emit(state.copyWith(
  //             locationPermissionStatus:
  //                 LocationPermissionStatus.permissionDenied,
  //           ));
  //         } else {
  //           emit(state.copyWith(
  //             locationPermissionStatus:
  //                 LocationPermissionStatus.permissionGranted,
  //           ));
  //         }
  //       },
  //     );
  //   } catch (e) {
  //     emit(state.copyWith(
  //       locationPermissionStatus: LocationPermissionStatus.permissionError,
  //       errorMessage: e.toString(),
  //     ));
  //   }
  // }
}
