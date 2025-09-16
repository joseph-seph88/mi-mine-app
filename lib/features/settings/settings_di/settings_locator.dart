import 'package:get_it/get_it.dart';
import 'package:mimine/core/infrastructure/device/permission_service.dart';
import 'package:mimine/core/services/my_info_service.dart';
import 'package:mimine/features/settings/data/settings_datasource.dart';
import 'package:mimine/features/settings/data/settings_repository_impl.dart';
import 'package:mimine/features/settings/domain/settings_repository.dart';
import 'package:mimine/features/settings/domain/settings_usecase.dart';
import 'package:mimine/features/settings/presentation/cubits/settings_cubit.dart';

void setupSettingsDependencies(GetIt getIt) {
  getIt.registerLazySingleton<SettingsDatasource>(
    () => SettingsDatasource(getIt<MyInfoService>()),
  );

  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(
      getIt<SettingsDatasource>(),
      getIt<PermissionService>(),
    ),
  );

  getIt.registerLazySingleton<SettingsUsecase>(
    () => SettingsUsecase(getIt<SettingsRepository>()),
  );

  getIt.registerLazySingleton<SettingsCubit>(
    () => SettingsCubit(getIt<SettingsUsecase>()),
  );
}
