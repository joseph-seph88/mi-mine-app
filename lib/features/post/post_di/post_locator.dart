import 'package:get_it/get_it.dart';
import 'package:mimine/core/infrastructure/network/api_client.dart';
import 'package:mimine/core/infrastructure/device/permission_service.dart';
import 'package:mimine/features/post/data/post_datasource.dart';
import 'package:mimine/features/post/data/post_repository_impl.dart';
import 'package:mimine/features/post/domain/post_repository.dart';
import 'package:mimine/features/post/domain/post_usecase.dart';
import 'package:mimine/features/post/presentation/cubits/post_cubit.dart';

void setupPostDependencies(GetIt getIt) {
  getIt.registerLazySingleton<PostDatasource>(
    () => PostDatasource(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<PostRepository>(
    () =>
        PostRepositoryImpl(getIt<PostDatasource>(), getIt<PermissionService>()),
  );
  getIt.registerLazySingleton<PostUsecase>(
    () => PostUsecase(getIt<PostRepository>()),
  );
  getIt.registerLazySingleton<PostCubit>(() => PostCubit(getIt<PostUsecase>()));
}
