import 'package:get_it/get_it.dart';
import 'package:mimine/core/infrastructure/device/location_service.dart';
import 'package:mimine/core/infrastructure/network/api_client.dart';
import 'package:mimine/core/infrastructure/storage/prefs_service.dart';
import 'package:mimine/core/infrastructure/device/permission_service.dart';
import 'package:mimine/core/services/places_service.dart';
import 'package:mimine/features/map/data/datasources/map_datasource.dart';
import 'package:mimine/features/map/data/repositories/map_permission_repository_impl.dart';
import 'package:mimine/features/map/data/repositories/map_repository_impl.dart';
import 'package:mimine/features/map/domain/repositories/map_permission_repository.dart';
import 'package:mimine/features/map/domain/repositories/map_repository.dart';
import 'package:mimine/features/map/domain/usecases/map_permission_usecase.dart';
import 'package:mimine/features/map/domain/usecases/map_usecase.dart';
import 'package:mimine/features/map/presentation/cubits/map_cubit.dart';

void setupMapDependencies(GetIt getIt) {
  getIt.registerLazySingleton<MapDatasource>(
    () => MapDatasource(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<MapRepository>(
    () => MapRepositoryImpl(getIt<PrefsService>(), getIt<PlacesService>(), getIt<LocationService>()),
  );
  getIt.registerLazySingleton<MapPermissionRepository>(
    () => MapPermissionRepositoryImpl(getIt<PermissionService>()),
  );
  getIt.registerLazySingleton<MapUsecase>(
    () => MapUsecase(getIt<MapRepository>()),
  );
  getIt.registerLazySingleton<MapPermissionUsecase>(
    () => MapPermissionUsecase(getIt<MapPermissionRepository>()),
  );
  getIt.registerLazySingleton<MapCubit>(
    () => MapCubit(
      getIt<MapUsecase>(),
      getIt<MapPermissionUsecase>(),
    ),
  );
}
