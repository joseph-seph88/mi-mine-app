import 'package:mimine/common/entities/post_entity.dart';
import 'package:mimine/common/entities/comment_entity.dart';
import 'package:mimine/common/entities/user_entity.dart';

abstract class CommunityRepository {
  Future<List<PostEntity>> getAllPosts({int page = 1, int size = 10});
  Future<List<PostEntity>> getAllBestPosts({int page = 1, int size = 10});
  Future<void> likePost(String postId);
  Future<void> incrementShareCount(String postId);
  Future<List<CommentEntity>> getComments(String postId);
  Future<void> addComment(String postId, String content);
  Future<UserEntity> getMyInfo();
  Future<void> setIsBookMarked(String postId);
}
