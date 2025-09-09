import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/common/enums/permission_status_type.dart';
import 'package:mimine/features/post/domain/entities/post_entity.dart';
import 'package:mimine/features/post/domain/post_usecase.dart';
import 'package:mimine/features/post/presentation/cubits/post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostUsecase _postUsecase;

  PostCubit(this._postUsecase) : super(PostState());

  Future<void> loadMyPosts() async {
    final response = await _postUsecase.getMyPosts('88');
    emit(state.copyWith(posts: response));
  }

  Future<void> loadMyBestPosts() async {
    final response = await _postUsecase.getMyBestPosts('88');
    emit(state.copyWith(bestPosts: response));
  }

  Future<void> createPost(
    String title,
    String description,
    String imageUrl,
  ) async {
    await _postUsecase.createPost(title, description, imageUrl);
  }

  Future<void> getPost(String postId) async {
    final response = await _postUsecase.getPost(postId);
    emit(state.copyWith(post: response));
  }

  Future<void> updatePost(
    String postId,
    String title,
    String description,
    String imageUrl,
  ) async {
    await _postUsecase.updatePost(postId, title, description, imageUrl);
  }

  Future<void> deletePost(String postId) async {
    await _postUsecase.deletePost(postId);
  }

  Future<void> likePost(String postId) async {
    await _postUsecase.likePost(postId);
  }

  void showComment() {
    emit(state.copyWith(showComment: !state.showComment));
  }

  Future<void> incrementShareCount(String postId) async {
    await _postUsecase.incrementShareCount(postId);
  }

  Future<void> setCommentPost(String postId, String comment) async {
    await _postUsecase.setCommentPost(postId, comment);
  }

  Future<void> getCommentPost(
    String postId, {
    int page = 1,
    int size = 10,
  }) async {
    final response = await _postUsecase.getCommentPost(
      postId,
      page: page,
      size: size,
    );
    emit(state.copyWith(comments: response));
  }

  Future<void> updateCommentPost(
    String postId,
    String commentId,
    String comment,
  ) async {
    await _postUsecase.updateCommentPost(postId, commentId, comment);
  }

  Future<void> deleteCommentPost(String postId, String commentId) async {
    await _postUsecase.deleteCommentPost(postId, commentId);
  }

  Future<void> openPermissionAppSettings(String permissionType) async {
    await _postUsecase.openPermissionAppSettings(permissionType);
  }

  void initializePostData(PostEntity post) {
    emit(state.copyWith(pickedImageUrl: post.imageUrl, hasImageChanged: false));
  }

  Future<bool> checkRequestPermission() async {
    try {
      emit(state.copyWith(permissionStatusType: null));

      final permissionTypes = state.requiredPermissionList;

      Map<String, String> permissionStatusMap = await _postUsecase
          .getPermissionStatuses(permissionTypes);

      final deniedPermissions = _getDeniedPermissionTypes(permissionStatusMap);
      if (deniedPermissions.isNotEmpty) {
        permissionStatusMap = await _postUsecase.requestPermissions(
          deniedPermissions,
        );
      }

      final hasPermanentlyDenied = permissionStatusMap.values.any(
        (status) => status == 'permanentlyDenied',
      );
      final hasDenied = permissionStatusMap.values.any(
        (status) => status == 'denied',
      );

      if (hasPermanentlyDenied) {
        emit(
          state.copyWith(
            permissionStatusType:
                PermissionStatusType.permissionPermanentlyDenied,
          ),
        );
        return false;
      } else if (hasDenied) {
        emit(
          state.copyWith(
            permissionStatusType: PermissionStatusType.permissionDenied,
          ),
        );
        return false;
      } else {
        emit(
          state.copyWith(
            permissionStatusType: PermissionStatusType.permissionGranted,
          ),
        );
        return true;
      }
    } catch (e) {
      emit(
        state.copyWith(
          permissionStatusType: PermissionStatusType.permissionDenied,
        ),
      );
      return false;
    }
  }

  List<String> _getDeniedPermissionTypes(Map<String, String> statusMap) {
    return statusMap.entries
        .where((entry) => entry.value == 'denied')
        .map((entry) => entry.key)
        .toList();
  }

  void updateImageUrl(String imageUrl, bool hasImageChanged) {
    emit(
      state.copyWith(
        pickedImageUrl: imageUrl,
        hasImageChanged: hasImageChanged,
      ),
    );
  }
}
