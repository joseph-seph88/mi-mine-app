import 'package:get_it/get_it.dart';
import 'package:mimine/core/infrastructure/storage/prefs_service.dart';
import 'package:mimine/core/infrastructure/device/permission_service.dart';
import 'package:mimine/features/map/data/map_repository_impl.dart';
import 'package:mimine/features/map/domain/map_repository.dart';
import 'package:mimine/features/map/domain/map_usecase.dart';
import 'package:mimine/features/map/presentation/cubits/map_cubit.dart';

void setupMapDependencies(GetIt getIt) {
  getIt.registerLazySingleton<MapRepository>(() => MapRepositoryImpl(getIt<PermissionService>(), getIt<PrefsService>()));
  getIt.registerLazySingleton<MapUsecase>(() => MapUsecase(getIt<MapRepository>()));
  getIt.registerLazySingleton<MapCubit>(() => MapCubit(getIt<MapUsecase>()));
}