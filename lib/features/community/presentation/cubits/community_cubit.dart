import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/common/enums/post_filter_type.dart';
import 'package:mimine/features/community/domain/community_usecase.dart';
import 'package:mimine/features/community/presentation/cubits/community_state.dart';

class CommunityCubit extends Cubit<CommunityState> {
  final CommunityUsecase _communityUsecase;

  CommunityCubit(this._communityUsecase) : super(CommunityState());

  Future<void> loadAllPosts() async {
    final response = await _communityUsecase.getAllPosts();
    emit(
      state.copyWith(allPosts: response, filterType: PostFilterType.allPost),
    );
  }

  Future<void> loadAllBestPosts() async {
    final response = await _communityUsecase.getAllBestPosts();
    emit(
      state.copyWith(
        allBestPosts: response,
        filterType: PostFilterType.allBestPost,
      ),
    );
  }

  void setFilterType(PostFilterType filterType) {
    emit(state.copyWith(filterType: filterType));
    switch (filterType) {
      case PostFilterType.allPost:
        emit(state.copyWith(filterType: PostFilterType.allPost));
        // loadAllPosts();
        break;
      case PostFilterType.allBestPost:
        emit(state.copyWith(filterType: PostFilterType.allBestPost));
        // loadAllBestPosts();
        break;
      default:
        emit(state.copyWith(filterType: PostFilterType.allPost));
        // loadAllPosts();
        break;
    }
  }

  Future<void> likePost(String postId) async {
    final isCurrentlyLiked = state.likedPostIds.contains(postId);
    final newLikedPostIds = Set<String>.from(state.likedPostIds);

    if (isCurrentlyLiked) {
      newLikedPostIds.remove(postId);
    } else {
      newLikedPostIds.add(postId);
    }

    emit(state.copyWith(likedPostIds: newLikedPostIds));
    await _communityUsecase.likePost(postId);
    _updatePostLikeCount(postId, isCurrentlyLiked ? -1 : 1);
  }

  void _updatePostLikeCount(String postId, int delta) {
    final currentPosts = state.allPosts ?? [];
    final currentBestPosts = state.allBestPosts ?? [];

    final updatedAllPosts = currentPosts.map((post) {
      if (post.postId == postId) {
        return post.copyWith(likeCount: (post.likeCount ?? 0) + delta);
      }
      return post;
    }).toList();

    final updatedAllBestPosts = currentBestPosts.map((post) {
      if (post.postId == postId) {
        return post.copyWith(likeCount: (post.likeCount ?? 0) + delta);
      }
      return post;
    }).toList();

    emit(
      state.copyWith(
        allPosts: updatedAllPosts,
        allBestPosts: updatedAllBestPosts,
      ),
    );
  }

  void showComment() {
    emit(state.copyWith(showComment: !state.showComment));
  }

  Future<void> incrementShareCount(String postId) async {
    await _communityUsecase.incrementShareCount(postId);
  }

  Future<void> setIsBookMarked(String postId) async {
    final isCurrentlyBookMarked = state.bookMarkedPostIds.contains(postId);
    final newBookMarkedPostIds = Set<String>.from(state.bookMarkedPostIds);

    if (isCurrentlyBookMarked) {
      newBookMarkedPostIds.remove(postId);
    } else {
      newBookMarkedPostIds.add(postId);
    }

    emit(state.copyWith(bookMarkedPostIds: newBookMarkedPostIds));
    await _communityUsecase.setIsBookMarked(postId);
    _updatePostBookMarked(postId, isCurrentlyBookMarked ? false : true);
  }

  Future<void> loadComments(String postId) async {
    final comments = await _communityUsecase.getComments(postId);
    emit(state.copyWith(comments: comments));
  }

  Future<void> addComment(String postId, String content) async {
    await _communityUsecase.addComment(postId, content);
    await loadComments(postId);
    _updatePostCommentCount(postId, 1);
  }

  void _updatePostCommentCount(String postId, int delta) {
    final currentPosts = state.allPosts ?? [];
    final currentBestPosts = state.allBestPosts ?? [];

    final updatedAllPosts = currentPosts.map((post) {
      if (post.postId == postId) {
        return post.copyWith(commentCount: (post.commentCount ?? 0) + delta);
      }
      return post;
    }).toList();

    final updatedAllBestPosts = currentBestPosts.map((post) {
      if (post.postId == postId) {
        return post.copyWith(commentCount: (post.commentCount ?? 0) + delta);
      }
      return post;
    }).toList();

    emit(
      state.copyWith(
        allPosts: updatedAllPosts,
        allBestPosts: updatedAllBestPosts,
      ),
    );
  }

  Future<void> getMyInfo() async {
    final response = await _communityUsecase.getMyInfo();
    emit(state.copyWith(userData: response));
  }

  void _updatePostBookMarked(String postId, bool bookMarked) {
    final currentPosts = state.allPosts ?? [];
    final currentBestPosts = state.allBestPosts ?? [];

    final updatedAllPosts = currentPosts.map((post) {
      if (post.postId == postId) {
        return post.copyWith(isBookMarked: bookMarked);
      }
      return post;
    }).toList();

    final updatedAllBestPosts = currentBestPosts.map((post) {
      if (post.postId == postId) {
        return post.copyWith(isBookMarked: bookMarked);
      }
      return post;
    }).toList();

    emit(
      state.copyWith(
        allPosts: updatedAllPosts,
        allBestPosts: updatedAllBestPosts,
      ),
    );
  }

  void searchPosts(String query) {
    emit(state.copyWith(filterType: PostFilterType.searchedPost));

    if (query.trim().isEmpty) {
      emit(state.copyWith(searchQuery: '', searchedPostList: null));
      return;
    }

    final currentPosts = state.filterType == PostFilterType.allPost
        ? state.allPosts ?? []
        : state.allBestPosts ?? [];

    final searchedPostList = currentPosts.where((post) {
      final searchQuery = query.toLowerCase();

      final hasMatchingTag =
          post.tags?.any((tag) => tag.toLowerCase().contains(searchQuery)) ??
          false;

      final hasMatchingUserId =
          post.userId?.toLowerCase().contains(searchQuery) ?? false;

      return hasMatchingTag || hasMatchingUserId;
    }).toList();

    emit(
      state.copyWith(searchQuery: query, searchedPostList: searchedPostList),
    );
  }

  void clearSearch() {
    emit(
      state.copyWith(
        searchQuery: '',
        searchedPostList: null,
        filterType: PostFilterType.allPost,
      ),
    );
  }
}
