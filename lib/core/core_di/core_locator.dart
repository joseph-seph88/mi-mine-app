import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:mimine/core/infrastructure/config/app_config.dart';
import 'package:mimine/core/infrastructure/config/env_config.dart';
import 'package:mimine/core/infrastructure/network/api_client.dart';
import 'package:mimine/core/infrastructure/network/dio_factory.dart';
import 'package:mimine/core/infrastructure/platform/location_service.dart';
import 'package:mimine/core/infrastructure/platform/permission_service.dart';
import 'package:mimine/core/infrastructure/storage/prefs_service.dart';
import 'package:mimine/core/infrastructure/storage/secure_storage_service.dart';
import 'package:mimine/core/services/my_info_service.dart';
import 'package:mimine/core/services/session_service.dart';
import 'package:mimine/core/services/local_token_service.dart';
import 'package:mimine/features/auth/auth_di/auth_locator.dart';
import 'package:mimine/features/home/home_di/home_locator.dart';
import 'package:mimine/features/splash/splash_di/splash_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  await _setupAsyncDependencies();
  _setupConfigDependencies();
  _setupEarlyServiceDependencies();
  _setupNetworkDependencies();
  _setupPlatformDependencies();
  _setupStorageDependencies();
  _setupLateServiceDependencies();
  _setupFeatureDependencies();
}

Future<void> _setupAsyncDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
}

void _setupConfigDependencies() {
  getIt.registerLazySingleton<EnvConfig>(() => EnvConfig.load());
  getIt.registerLazySingleton<AppConfig>(
      () => AppConfig.load(getIt<EnvConfig>()));
}

void _setupNetworkDependencies() {
  getIt.registerLazySingleton<DioFactory>(
      () => DioFactory(getIt<LocalTokenService>(), getIt<EnvConfig>()));
  getIt.registerLazySingleton<ApiClient>(
      () => ApiClient(getIt<DioFactory>().createWithInterceptors()));
}

void _setupPlatformDependencies() {
  getIt.registerLazySingleton<PermissionService>(() => PermissionService());
  getIt.registerLazySingleton<LocationService>(() => LocationService());
}

void _setupStorageDependencies() {
  getIt.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());
  getIt.registerLazySingleton<SecureStorageService>(
      () => SecureStorageService(getIt<FlutterSecureStorage>()));
  getIt.registerLazySingleton<PrefsService>(
      () => PrefsService(getIt<SharedPreferences>()));
}

void _setupEarlyServiceDependencies() {
  getIt.registerLazySingleton<LocalTokenService>(() =>
      LocalTokenService(getIt<SecureStorageService>(), getIt<EnvConfig>()));
}

void _setupLateServiceDependencies() {
  getIt.registerLazySingleton<SessionService>(
      () => SessionService(getIt<ApiClient>()));
  getIt.registerLazySingleton<MyInfoService>(
      () => MyInfoService(getIt<ApiClient>()));
}

void _setupFeatureDependencies() {
  setupAuthDependencies(getIt);
  setupSplashDependencies(getIt);
  setupHomeDependencies(getIt);
}
