import 'package:get_it/get_it.dart';
import 'package:mimine/core/http/api_client.dart';
import 'package:mimine/features/auth/data/auth_datasource.dart';
import 'package:mimine/features/auth/data/auth_repository_Impl.dart';
import 'package:mimine/features/auth/domain/auth_repository.dart';
import 'package:mimine/features/auth/domain/usecases/login_usecase.dart';
import 'package:mimine/features/auth/presentation/cubits/login_cubit/login_cubit.dart';

void setupAuthDependencies(GetIt getIt) {
  getIt.registerLazySingleton<AuthDatasource>(() => AuthDatasource(getIt<ApiClient>()));
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt<AuthDatasource>()));
  getIt.registerLazySingleton<LoginUsecase>(() => LoginUsecase(getIt<AuthRepository>()));
  getIt.registerLazySingleton<LoginCubit>(() => LoginCubit(getIt<LoginUsecase>()));
}
