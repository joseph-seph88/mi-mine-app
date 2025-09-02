import 'package:get_it/get_it.dart';
import 'package:mimine/features/splash/presentation/cubits/splash_cubit.dart';

void setupSplashDependencies(GetIt getIt) {
  getIt.registerLazySingleton<SplashCubit>(() => SplashCubit());
}
