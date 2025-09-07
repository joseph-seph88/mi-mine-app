import 'package:get_it/get_it.dart';
import 'package:mimine/core/infrastructure/storage/prefs_service.dart';
import 'package:mimine/core/services/permission_service.dart';
import 'package:mimine/features/shell/data/shell_repository_impl.dart';
import 'package:mimine/features/shell/domain/shell_repository.dart';
import 'package:mimine/features/shell/domain/shell_usecase.dart';
import 'package:mimine/features/shell/presentation/cubits/shell_cubit.dart';

void setupShellDependencies(GetIt getIt) {
  getIt.registerLazySingleton<ShellRepository>(
      () => ShellRepositoryImpl(getIt<PermissionService>(), getIt<PrefsService>()));
  getIt.registerLazySingleton<ShellUsecase>(
      () => ShellUsecase(getIt<ShellRepository>()));
  getIt.registerLazySingleton<ShellCubit>(
      () => ShellCubit(getIt<ShellUsecase>()));
}
