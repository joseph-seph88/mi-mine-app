import 'package:mimine/common/entities/user_entity.dart';
import 'package:mimine/features/community/domain/community_repository.dart';
import 'package:mimine/common/entities/post_entity.dart';
import 'package:mimine/common/entities/comment_entity.dart';

class CommunityUsecase {
  final CommunityRepository _communityRepository;

  CommunityUsecase(this._communityRepository);

  Future<List<PostEntity>> getAllPosts({int page = 1, int size = 10}) async {
    return await _communityRepository.getAllPosts(page: page, size: size);
  }

  Future<List<PostEntity>> getAllBestPosts({
    int page = 1,
    int size = 10,
  }) async {
    return await _communityRepository.getAllBestPosts(page: page, size: size);
  }

  Future<void> likePost(String postId) async {
    await _communityRepository.likePost(postId);
  }

  Future<void> setIsBookMarked(String postId) async {
    await _communityRepository.setIsBookMarked(postId);
  }

  Future<void> incrementShareCount(String postId) async {
    await _communityRepository.incrementShareCount(postId);
  }

  Future<List<CommentEntity>> getComments(String postId) async {
    return await _communityRepository.getComments(postId);
  }

  Future<void> addComment(String postId, String content) async {
    await _communityRepository.addComment(postId, content);
  }

  Future<UserEntity> getMyInfo() async {
    return await _communityRepository.getMyInfo();
  }
}
