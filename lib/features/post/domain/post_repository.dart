import 'package:mimine/features/post/domain/entities/comment_entity.dart';
import 'package:mimine/features/post/domain/entities/post_entity.dart';

abstract class PostRepository {
  Future<void> createPost(String title, String description, String imageUrl);
  Future<PostEntity> getPost(String postId);
  Future<List<PostEntity>> getMyPosts(String postId);
  Future<List<PostEntity>> getMyBestPosts(String postId);
  Future<void> updatePost(
    String postId,
    String title,
    String description,
    String imageUrl,
  );
  Future<void> deletePost(String postId);
  Future<void> likePost(String postId);
  Future<void> incrementShareCount(String postId);
  Future<void> setCommentPost(String postId, String comment);
  Future<List<CommentEntity>> getCommentPost(
    String postId, {
    int page = 1,
    int size = 10,
  });
  Future<void> updateCommentPost(
    String postId,
    String commentId,
    String comment,
  );
  Future<void> deleteCommentPost(String postId, String commentId);
  Future<bool> checkAllPermissions(List<String> permissionTypes);
  Future<Map<String, String>> checkPermissionStatuses(
    List<String> permissionTypes,
  );
  Future<Map<String, String>> requestPermissions(List<String> permissionTypes);
  Future<bool> openPermissionAppSettings(String permissionType);
}
