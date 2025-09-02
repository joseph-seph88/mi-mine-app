import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:mimine/core/configs/app_config.dart';
import 'package:mimine/core/configs/env_config.dart';
import 'package:mimine/core/http/api_client.dart';
import 'package:mimine/core/http/dio_factory.dart';
import 'package:mimine/core/storage/storage_manager.dart';
import 'package:mimine/core/storage/token_manager.dart';
import 'package:mimine/features/auth/auth_di/auth_locator.dart';
import 'package:mimine/features/splash/splash_di/splash_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

void setupLocator() {
  _setupConfigDependencies();
  _setupHttpDependencies();
  _setupManagerDependencies();
  _setupServiceDependencies();
  _setupFeatureDependencies();
}

void _setupConfigDependencies() {
  getIt.registerLazySingleton<EnvConfig>(() => EnvConfig.load());
  getIt.registerLazySingleton<AppConfig>(
      () => AppConfig.load(getIt<EnvConfig>()));
}

void _setupManagerDependencies() {
  getIt.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());
  getIt.registerLazySingleton<TokenManager>(
      () => TokenManager(getIt<FlutterSecureStorage>(), getIt<EnvConfig>()));
  getIt.registerLazySingleton<StorageManager>(
      () => StorageManager(getIt<SharedPreferences>()));
}

void _setupHttpDependencies() {
  getIt.registerLazySingleton<DioFactory>(
      () => DioFactory(getIt<TokenManager>(), getIt<EnvConfig>()));
  getIt.registerLazySingleton<ApiClient>(
      () => ApiClient(getIt<DioFactory>().createWithInterceptors()));
  
}

void _setupServiceDependencies() {
  // getIt.registerLazySingleton<PermissionService>(() => PermissionService());
}

void _setupFeatureDependencies() {
  setupAuthDependencies(getIt);
  // setupMainDependencies(getIt);
  setupSplashDependencies(getIt);
  // setupMapDependencies(getIt);
}
