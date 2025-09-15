import 'package:mimine/common/entities/comment_entity.dart';
import 'package:mimine/common/entities/post_entity.dart';
import 'package:mimine/core/infrastructure/device/permission_service.dart';
import 'package:mimine/core/utils/formatter/permission_formatter.dart';
import 'package:mimine/features/post/data/post_datasource.dart';
import 'package:mimine/features/post/domain/post_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class PostRepositoryImpl implements PostRepository {
  final PostDatasource _postDatasource;
  final PermissionService _permissionService;

  PostRepositoryImpl(this._postDatasource, this._permissionService);

  @override
  Future<void> createPost(
    String title,
    String description,
    String imageUrl,
  ) async {
    await _postDatasource.createPost(title, description, imageUrl);
  }

  @override
  Future<PostEntity> getPost(String postId) async {
    final response = await _postDatasource.getPost(postId);
    final responseData = response.data as Map<String, dynamic>;
    return PostEntity.fromJson(responseData);
  }

  @override
  Future<void> updatePost(
    String postId,
    String title,
    String description,
    String imageUrl,
  ) async {
    await _postDatasource.updatePost(postId, title, description, imageUrl);
  }

  @override
  Future<void> deletePost(String postId) async {
    await _postDatasource.deletePost(postId);
  }

  @override
  Future<void> likePost(String postId) async {
    await _postDatasource.likePost(postId);
  }

  @override
  Future<void> incrementShareCount(String postId) async {
    await _postDatasource.incrementShareCount(postId);
  }

  @override
  Future<void> setCommentPost(String postId, String comment) async {
    await _postDatasource.setCommentPost(postId, comment);
  }

  @override
  Future<List<CommentEntity>> getCommentPost(
    String postId, {
    int page = 1,
    int size = 10,
  }) async {
    final response = await _postDatasource.getCommentPost(
      postId,
      page: page,
      size: size,
    );
    final responseData = response.data as List<Map<String, dynamic>>;
    return responseData.map((e) => CommentEntity.fromJson(e)).toList();
  }

  @override
  Future<void> updateCommentPost(
    String postId,
    String commentId,
    String comment,
  ) async {
    await _postDatasource.updateCommentPost(postId, commentId, comment);
  }

  @override
  Future<void> deleteCommentPost(String postId, String commentId) async {
    await _postDatasource.deleteCommentPost(postId, commentId);
  }

  @override
  Future<bool> checkAllPermissions(List<String> permissionTypes) async {
    for (String permissionType in permissionTypes) {
      final permission = PermissionUtils.stringToPermission(permissionType);
      final result = await _permissionService.checkPermission(permission);
      final permissionStatus = result.data as PermissionStatus;
      if (permissionStatus != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  @override
  Future<Map<String, String>> checkPermissionStatuses(
    List<String> permissionTypes,
  ) async {
    final Map<String, String> statusMap = {};
    for (String permissionType in permissionTypes) {
      final permission = PermissionUtils.stringToPermission(permissionType);
      final result = await _permissionService.checkPermission(permission);
      final permissionStatus = result.data as PermissionStatus;
      statusMap[permissionType] = PermissionUtils.permissionStatusToString(
        permissionStatus,
      );
    }
    return statusMap;
  }

  @override
  Future<Map<String, String>> requestPermissions(
    List<String> permissionTypes,
  ) async {
    final Map<String, String> statusMap = {};
    for (String permissionType in permissionTypes) {
      final permission = PermissionUtils.stringToPermission(permissionType);
      final result = await _permissionService.requestPermission(permission);
      final permissionStatus = result.data as PermissionStatus;
      statusMap[permissionType] = PermissionUtils.permissionStatusToString(
        permissionStatus,
      );
    }
    return statusMap;
  }

  @override
  Future<bool> openPermissionAppSettings(String permissionType) async {
    final permission = PermissionUtils.stringToPermission(permissionType);
    final result = await _permissionService.openPermissionAppSettings(
      permission,
    );
    return result.data as bool;
  }
}
