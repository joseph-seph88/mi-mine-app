import 'package:get_it/get_it.dart';
import 'package:mimine/features/splash/presentation/blocs/splash_bloc.dart';

void setupSplashDependencies(GetIt getIt) {
  getIt.registerLazySingleton<SplashBloc>(() => SplashBloc());
}
