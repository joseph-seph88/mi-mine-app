import 'package:mimine/features/community/data/community_datasource.dart';
import 'package:mimine/features/community/domain/community_repository.dart';
import 'package:mimine/features/post/domain/entities/post_entity.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityDatasource _communityDatasource;

  CommunityRepositoryImpl(this._communityDatasource);

  @override
  Future<List<PostEntity>> getAllPosts({int page = 1, int size = 10}) async {
    final response = await _communityDatasource.getAllPosts(page: page, size: size);
    final responseData = response.data as List<Map<String, dynamic>>;
    return responseData.map((e) => PostEntity.fromJson(e)).toList();
  }
}