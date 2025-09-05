import 'package:get_it/get_it.dart';
import 'package:mimine/core/services/my_info_service.dart';
import 'package:mimine/features/home/data/home_repository_impl.dart';
import 'package:mimine/features/home/domain/home_repository.dart';
import 'package:mimine/features/home/domain/home_usecase.dart';
import 'package:mimine/features/home/presentation/cubits/ad/ad_cubit.dart';
import 'package:mimine/features/home/presentation/cubits/home/home_cubit.dart';

void setupHomeDependencies(GetIt getIt) {
  getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(getIt<MyInfoService>()));
  getIt.registerLazySingleton<HomeUsecase>(
      () => HomeUsecase(getIt<HomeRepository>()));
  getIt.registerLazySingleton<HomeCubit>(() => HomeCubit(getIt<HomeUsecase>()));
  getIt.registerLazySingleton<AdCubit>(() => AdCubit());
}
