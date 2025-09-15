import 'package:get_it/get_it.dart';
import 'package:mimine/core/infrastructure/network/api_client.dart';
import 'package:mimine/core/services/my_info_service.dart';
import 'package:mimine/features/community/data/community_datasource.dart';
import 'package:mimine/features/community/data/community_repository_impl.dart';
import 'package:mimine/features/community/domain/community_repository.dart';
import 'package:mimine/features/community/domain/community_usecase.dart';
import 'package:mimine/features/community/presentation/cubits/community_cubit.dart';

void setupCommunityDependencies(GetIt getIt) {
  getIt.registerLazySingleton<CommunityDatasource>(
    () => CommunityDatasource(getIt<ApiClient>(), getIt<MyInfoService>()),
  );
  getIt.registerLazySingleton<CommunityRepository>(
    () => CommunityRepositoryImpl(getIt<CommunityDatasource>()),
  );
  getIt.registerLazySingleton<CommunityUsecase>(
    () => CommunityUsecase(getIt<CommunityRepository>()),
  );

  getIt.registerFactory<CommunityCubit>(
    () => CommunityCubit(getIt<CommunityUsecase>()),
  );
}
