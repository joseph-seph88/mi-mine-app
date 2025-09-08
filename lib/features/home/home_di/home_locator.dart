import 'package:get_it/get_it.dart';
import 'package:mimine/core/infrastructure/network/api_client.dart';
import 'package:mimine/core/infrastructure/storage/prefs_service.dart';
import 'package:mimine/core/services/ad_info_service.dart';
import 'package:mimine/core/services/my_info_service.dart';
import 'package:mimine/core/services/notification_info_service.dart';
import 'package:mimine/core/services/permission_service.dart';
import 'package:mimine/features/home/data/home_datasource.dart';
import 'package:mimine/features/home/data/home_repository_impl.dart';
import 'package:mimine/features/home/domain/home_repository.dart';
import 'package:mimine/features/home/domain/home_usecase.dart';
import 'package:mimine/features/home/presentation/cubits/ad/ad_cubit.dart';
import 'package:mimine/features/home/presentation/cubits/home/home_cubit.dart';
import 'package:mimine/features/home/presentation/cubits/notification/notification_cubit.dart';

/// TODO: Home 분리 필요
void setupHomeDependencies(GetIt getIt) {
  getIt.registerLazySingleton<HomeDatasource>(() => HomeDatasource(getIt<ApiClient>()));
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
      getIt<MyInfoService>(),
      getIt<AdInfoService>(),
      getIt<NotificationInfoService>(),
      getIt<HomeDatasource>(),
      getIt<PermissionService>(),
      getIt<PrefsService>()));
  getIt.registerLazySingleton<HomeUsecase>(
      () => HomeUsecase(getIt<HomeRepository>()));
  getIt.registerLazySingleton<HomeCubit>(() => HomeCubit(getIt<HomeUsecase>()));
  getIt.registerLazySingleton<AdCubit>(() => AdCubit(getIt<HomeUsecase>()));
  getIt.registerLazySingleton<NotificationCubit>(
      () => NotificationCubit(getIt<HomeUsecase>()));
}
