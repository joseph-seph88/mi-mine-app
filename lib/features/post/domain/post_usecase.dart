import 'package:mimine/features/post/domain/entities/comment_entity.dart';
import 'package:mimine/features/post/domain/entities/post_entity.dart';
import 'package:mimine/features/post/domain/post_repository.dart';

class PostUsecase {
  final PostRepository _postRepository;

  PostUsecase(this._postRepository);

  Future<void> createPost(
    String title,
    String description,
    String imageUrl,
  ) async {
    await _postRepository.createPost(title, description, imageUrl);
  }

  Future<PostEntity> getPost(String postId) async {
    return await _postRepository.getPost(postId);
  }

  Future<List<PostEntity>> getMyPosts(String userId) async {
    return await _postRepository.getMyPosts(userId);
  }

  Future<List<PostEntity>> getMyBestPosts(String userId) async {
    return await _postRepository.getMyBestPosts(userId);
  }

  Future<void> updatePost(
    String postId,
    String title,
    String description,
    String imageUrl,
  ) async {
    await _postRepository.updatePost(postId, title, description, imageUrl);
  }

  Future<void> deletePost(String postId) async {
    await _postRepository.deletePost(postId);
  }

  Future<void> likePost(String postId) async {
    await _postRepository.likePost(postId);
  }

  Future<void> incrementShareCount(String postId) async {
    await _postRepository.incrementShareCount(postId);
  }

  Future<void> setCommentPost(String postId, String comment) async {
    await _postRepository.setCommentPost(postId, comment);
  }

  Future<List<CommentEntity>> getCommentPost(
    String postId, {
    int page = 1,
    int size = 10,
  }) async {
    return await _postRepository.getCommentPost(postId, page: page, size: size);
  }

  Future<void> updateCommentPost(
    String postId,
    String commentId,
    String comment,
  ) async {
    await _postRepository.updateCommentPost(postId, commentId, comment);
  }

  Future<void> deleteCommentPost(String postId, String commentId) async {
    await _postRepository.deleteCommentPost(postId, commentId);
  }

  Future<bool> checkAllPermissions(List<String> permissionTypes) async {
    return await _postRepository.checkAllPermissions(permissionTypes);
  }

  Future<Map<String, String>> getPermissionStatuses(
    List<String> permissionTypes,
  ) async {
    return await _postRepository.getPermissionStatuses(permissionTypes);
  }

  Future<Map<String, String>> requestPermissions(
    List<String> permissionTypes,
  ) async {
    return await _postRepository.requestPermissions(permissionTypes);
  }

  Future<bool> openPermissionAppSettings(String permissionType) async {
    return await _postRepository.openPermissionAppSettings(permissionType);
  }
}
