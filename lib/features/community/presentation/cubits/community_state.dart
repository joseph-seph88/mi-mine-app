import 'package:equatable/equatable.dart';
import 'package:mimine/common/entities/comment_entity.dart';
import 'package:mimine/common/entities/post_entity.dart';
import 'package:mimine/common/entities/user_entity.dart';
import 'package:mimine/common/enums/permission_status_type.dart';
import 'package:mimine/common/enums/post_filter_type.dart';

class CommunityState extends Equatable {
  final List<PostEntity>? allPosts;
  final List<PostEntity>? allBestPosts;
  final List<CommentEntity>? comments;
  final String? errorMessage;
  final bool showComment;
  final Set<String> likedPostIds;
  final UserEntity? userData;
  final String? pickedImageUrl;
  final bool hasImageChanged;
  final List<String> requiredPermissionList;
  final Map<String, String>? permissionStatusMap;
  final PermissionStatusType? permissionStatusType;
  final PostFilterType filterType;
  final Set<String> bookMarkedPostIds;
  final String searchQuery;
  final List<PostEntity>? searchedPostList;    

  const CommunityState({
    this.allPosts,
    this.allBestPosts,
    this.comments,
    this.errorMessage,
    this.showComment = false,
    this.likedPostIds = const {},
    this.userData,
    this.pickedImageUrl,
    this.hasImageChanged = false,
    this.requiredPermissionList = const ['camera', 'photos'],
    this.permissionStatusMap,
    this.permissionStatusType,
    this.filterType = PostFilterType.allPost,
    this.bookMarkedPostIds = const {},
    this.searchQuery = '',
    this.searchedPostList,
  });

  CommunityState copyWith({
    List<PostEntity>? allPosts,
    List<PostEntity>? allBestPosts,
    List<CommentEntity>? comments,
    String? errorMessage,
    bool? showComment,
    Set<String>? likedPostIds,
    UserEntity? userData,
    String? pickedImageUrl,
    bool? hasImageChanged,
    List<String>? requiredPermissionList,
    Map<String, String>? permissionStatusMap,
    PermissionStatusType? permissionStatusType,
    PostFilterType? filterType,
    Set<String>? bookMarkedPostIds,
    String? searchQuery,
    List<PostEntity>? searchedPostList,
  }) {
    return CommunityState(
      allPosts: allPosts ?? this.allPosts,
      allBestPosts: allBestPosts ?? this.allBestPosts,
      comments: comments ?? this.comments,
      errorMessage: errorMessage ?? this.errorMessage,
      showComment: showComment ?? this.showComment,
      likedPostIds: likedPostIds ?? this.likedPostIds,
      userData: userData ?? this.userData,
      pickedImageUrl: pickedImageUrl ?? this.pickedImageUrl,
      hasImageChanged: hasImageChanged ?? this.hasImageChanged,
      requiredPermissionList:
          requiredPermissionList ?? this.requiredPermissionList,
      permissionStatusMap: permissionStatusMap ?? this.permissionStatusMap,
      permissionStatusType: permissionStatusType ?? this.permissionStatusType,
      filterType: filterType ?? this.filterType,
      bookMarkedPostIds: bookMarkedPostIds ?? this.bookMarkedPostIds,
      searchQuery: searchQuery ?? this.searchQuery,
      searchedPostList: searchedPostList ?? this.searchedPostList,
    );
  }

  @override
  List<Object?> get props => [
    allPosts,
    allBestPosts,
    comments,
    errorMessage,
    showComment,
    likedPostIds,
    userData,
    pickedImageUrl,
    hasImageChanged,
    requiredPermissionList,
    permissionStatusMap,
    permissionStatusType,
    filterType,
    bookMarkedPostIds,
    searchQuery,
    searchedPostList,
  ];
}
