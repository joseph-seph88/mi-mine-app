import 'package:mimine/common/entities/user_entity.dart';
import 'package:mimine/features/community/data/community_datasource.dart';
import 'package:mimine/features/community/domain/community_repository.dart';
import 'package:mimine/common/entities/post_entity.dart';
import 'package:mimine/common/entities/comment_entity.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityDatasource _communityDatasource;

  CommunityRepositoryImpl(this._communityDatasource);

  @override
  Future<List<PostEntity>> getAllPosts({int page = 1, int size = 10}) async {
    final response = await _communityDatasource.getAllPosts(
      page: page,
      size: size,
    );
    final responseData = response.data as List<Map<String, dynamic>>;
    return responseData.map((e) => PostEntity.fromJson(e)).toList();
  }

  @override
  Future<List<PostEntity>> getAllBestPosts({
    int page = 1,
    int size = 10,
  }) async {
    final response = await _communityDatasource.getAllBestPosts(
      page: page,
      size: size,
    );
    final responseData = response.data as List<Map<String, dynamic>>;
    return responseData.map((e) => PostEntity.fromJson(e)).toList();
  }

  @override
  Future<void> likePost(String postId) async {
    await _communityDatasource.likePost(postId);
  }

  @override
  Future<void> incrementShareCount(String postId) async {
    await _communityDatasource.incrementShareCount(postId);
  }

  @override
  Future<List<CommentEntity>> getComments(String postId) async {
    final response = await _communityDatasource.getComments(postId);
    final responseData = response.data as List<Map<String, dynamic>>;
    return responseData.map((e) => CommentEntity.fromJson(e)).toList();
  }

  @override
  Future<void> addComment(String postId, String content) async {
    await _communityDatasource.addComment(postId, content);
  }

  @override
  Future<UserEntity> getMyInfo() async {
    final response = await _communityDatasource.getMyInfo();
    final responseData = response.data as Map<String, dynamic>;
    return UserEntity.fromJson(
      responseData,
      response.statusMessage ?? '',
      response.isSuccess ?? false,
    );
  }

  @override
  Future<void> setIsBookMarked(String postId) async {
    await _communityDatasource.setIsBookMarked(postId);
  }
}
