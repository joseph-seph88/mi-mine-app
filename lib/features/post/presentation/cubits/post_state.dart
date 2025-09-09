import 'package:equatable/equatable.dart';
import 'package:mimine/common/entities/user_entity.dart';
import 'package:mimine/common/enums/permission_status_type.dart';
import 'package:mimine/features/post/domain/entities/comment_entity.dart';
import 'package:mimine/features/post/domain/entities/post_entity.dart';

class PostState extends Equatable {
  final List<PostEntity>? posts;
  final List<PostEntity>? bestPosts;
  final PostEntity? post;
  final List<CommentEntity>? comments;
  final String? errorMessage;
  final bool showComment;
  final bool isLiked;
  final UserEntity? userData;
  final String? pickedImageUrl;
  final bool hasImageChanged;
  final List<String> requiredPermissionList;
  final Map<String, String>? permissionStatusMap;
  final PermissionStatusType? permissionStatusType;

  const PostState({
    this.posts,
    this.bestPosts,
    this.post,
    this.comments,
    this.errorMessage,
    this.showComment = false,
    this.isLiked = false,
    this.userData,
    this.pickedImageUrl,
    this.hasImageChanged = false,
    this.requiredPermissionList = const ['camera', 'photos'],
    this.permissionStatusMap,
    this.permissionStatusType,
  });

  PostState copyWith({
    List<PostEntity>? posts,
    List<PostEntity>? bestPosts,
    PostEntity? post,
    List<CommentEntity>? comments,
    String? errorMessage,
    bool? showComment,
    bool? isLiked,
    UserEntity? userData,
    String? pickedImageUrl,
    bool? hasImageChanged,
    List<String>? requiredPermissionList,
    Map<String, String>? permissionStatusMap,
    PermissionStatusType? permissionStatusType,
  }) {
    return PostState(
      posts: posts ?? this.posts,
      bestPosts: bestPosts ?? this.bestPosts,
      post: post ?? this.post,
      comments: comments ?? this.comments,
      errorMessage: errorMessage ?? this.errorMessage,
      showComment: showComment ?? this.showComment,
      isLiked: isLiked ?? this.isLiked,
      userData: userData ?? this.userData,
      pickedImageUrl: pickedImageUrl ?? this.pickedImageUrl,
      hasImageChanged: hasImageChanged ?? this.hasImageChanged,
      requiredPermissionList:
          requiredPermissionList ?? this.requiredPermissionList,
      permissionStatusMap: permissionStatusMap ?? this.permissionStatusMap,
      permissionStatusType: permissionStatusType ?? this.permissionStatusType,
    );
  }

  @override
  List<Object?> get props => [
    posts,
    bestPosts,
    post,
    comments,
    errorMessage,
    showComment,
    isLiked,
    userData,
    pickedImageUrl,
    hasImageChanged,
    requiredPermissionList,
    permissionStatusMap,
    permissionStatusType,
  ];
}
