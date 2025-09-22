import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/common/entities/post_entity.dart';
import 'package:mimine/common/enums/post_filter_type.dart';
import 'package:mimine/common/widgets/network_image_widget.dart';
import 'package:mimine/common/widgets/search_bar_widget.dart';
import 'package:mimine/features/community/presentation/cubits/community_cubit.dart';
import 'package:mimine/features/community/presentation/cubits/community_state.dart';
import 'package:mimine/features/community/presentation/widgets/comment_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../common/styles/app_colors.dart';
import '../../../../../common/styles/app_text_styles.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final GlobalKey menuButtonKey = GlobalKey();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CommunityCubit>().resetFilter();
    context.read<CommunityCubit>().loadAllPosts();
    context.read<CommunityCubit>().loadAllBestPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityCubit, CommunityState>(
      builder: (context, state) {
        List<PostEntity> postList = [];

        if (state.filterType == PostFilterType.allPost) {
          postList = state.allPosts ?? [];
        } else if (state.filterType == PostFilterType.allBestPost) {
          postList = state.allBestPosts ?? [];
        } else if (state.filterType == PostFilterType.searchedPost) {
          postList = state.searchedPostList ?? [];
        }

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                _buildHeaderSection(context, state),
                _buildFilterSection(context, state),
                if (state.searchQuery.isNotEmpty)
                  _buildSearchStatusSection(context, state),
                const SizedBox(height: 12),
                Expanded(
                  child: postList.isEmpty
                      ? _buildEmptyState(state)
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                          itemCount: postList.length,
                          itemBuilder: (context, index) {
                            final post = postList[index];
                            return _buildPostCard(context, post, index);
                          },
                        ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.pushNamed(RouterName.createPost),
            backgroundColor: AppColors.primary,
            child: Icon(Icons.add, color: AppColors.white),
          ),
        );
      },
    );
  }

  Widget _buildHeaderSection(BuildContext context, CommunityState state) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      height: 80,
      child: SearchBarWidget(
        hintText: "태그 또는 아이디 검색..",
        onSubmitted: (query) {
          context.read<CommunityCubit>().searchPosts(query);
        },
        controller: _searchController,
        onSearchPressed: () =>
            context.read<CommunityCubit>().searchPosts(_searchController.text),
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context, CommunityState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: _buildFilterButton(
              context,
              '전체 게시글',
              PostFilterType.allPost,
              state.filterType == PostFilterType.allPost,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildFilterButton(
              context,
              '인기 게시글',
              PostFilterType.allBestPost,
              state.filterType == PostFilterType.allBestPost,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchStatusSection(BuildContext context, CommunityState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(Icons.search, size: 20, color: AppColors.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '검색어: "${state.searchQuery}" (${state.searchedPostList?.length ?? 0}개 결과)',
              style: AppTextStyles.blackF16H145.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => context.read<CommunityCubit>().clearSearch(),
            child: Icon(Icons.close, size: 20, color: AppColors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(
    BuildContext context,
    String text,
    PostFilterType filterType,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () => context.read<CommunityCubit>().setFilterType(filterType),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.grey.withAlpha(51),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withAlpha(8),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppTextStyles.blackF14W700H12.copyWith(
            color: isSelected ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(CommunityState state) {
    if (state.searchQuery.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: AppColors.grey.withAlpha(128),
            ),
            const SizedBox(height: 16),
            Text(
              '검색 결과가 없습니다',
              style: AppTextStyles.greyF13.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              '"${state.searchQuery}"에 대한 검색 결과가 없습니다',
              style: AppTextStyles.greyF13,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.read<CommunityCubit>().clearSearch(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
              ),
              child: Text('검색 초기화'),
            ),
          ],
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.article_outlined,
            size: 64,
            color: AppColors.grey.withAlpha(128),
          ),
          const SizedBox(height: 16),
          Text(
            '게시글이 없습니다',
            style: AppTextStyles.greyF13.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text('첫 번째 게시글을 작성해보세요!', style: AppTextStyles.greyF13),
        ],
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, PostEntity post, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey.withAlpha(51), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(12),
            blurRadius: 16,
            offset: const Offset(0, 6),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPostTopSection(context, post, index),
          _buildPostContentSection(post),
          const SizedBox(height: 12),
          if (post.imageUrl != null && post.imageUrl!.isNotEmpty)
            _buildPostImageSection(post),
          const SizedBox(height: 16),
          _buildPostTagSection(post.tags ?? []),
          const SizedBox(height: 16),
          _buildPostBottomSection(context, post, index),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildPostTopSection(
    BuildContext context,
    PostEntity post,
    int index,
  ) {
    return GestureDetector(
      onTap: () => context.pushNamed(
        RouterName.otherUserCommunity,
        pathParameters: {'userId': post.userId.toString()},
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.primary.withAlpha(25),
              child: NetworkImageWidget.networkImage(),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User${post.postId ?? index + 1}',
                    style: AppTextStyles.blackF16H145.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${index + 1}시간 전',
                    style: AppTextStyles.greyF13.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostContentSection(PostEntity post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (post.title != null && post.title!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                post.title!,
                style: AppTextStyles.blackF16H145.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ),
          Text(
            post.description ?? '내용이 없습니다.',
            style: AppTextStyles.blackF16H145.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildPostImageSection(PostEntity post) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          post.imageUrl!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 200,
          errorBuilder: (context, error, stackTrace) =>
              Center(child: Icon(Icons.image, size: 50, color: AppColors.grey)),
        ),
      ),
    );
  }

  Widget _buildPostBottomSection(
    BuildContext context,
    PostEntity post,
    int index,
  ) {
    final likeCount = post.likeCount;
    final commentCount = post.commentCount;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Row(
            children: [
              BlocBuilder<CommunityCubit, CommunityState>(
                builder: (context, state) {
                  final isLiked = state.likedPostIds.contains(post.postId);
                  return IconButton(
                    onPressed: () {
                      context.read<CommunityCubit>().likePost(
                        post.postId.toString(),
                      );
                    },
                    icon: Icon(
                      isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                      color: isLiked ? AppColors.primary : AppColors.grey,
                      size: 22,
                    ),
                  );
                },
              ),
              Text(
                '$likeCount',
                style: AppTextStyles.greyF13.copyWith(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Row(
            children: [
              IconButton(
                onPressed: () => _showCommentBottomSheet(context, post),
                icon: Icon(
                  Icons.comment_outlined,
                  color: AppColors.grey,
                  size: 22,
                ),
              ),
              Text(
                '$commentCount',
                style: AppTextStyles.greyF13.copyWith(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () => _sharePost(context, post),
            icon: Icon(Icons.share_outlined, color: AppColors.grey, size: 22),
          ),
          const Spacer(),

          BlocBuilder<CommunityCubit, CommunityState>(
            builder: (context, state) {
              final isBookMarked = state.bookMarkedPostIds.contains(
                post.postId,
              );
              return IconButton(
                onPressed: () => context.read<CommunityCubit>().setIsBookMarked(
                  post.postId.toString(),
                ),
                icon: Icon(
                  isBookMarked ? Icons.bookmark : Icons.bookmark_outline,
                  color: isBookMarked ? AppColors.primary : AppColors.grey,
                  size: 22,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPostTagSection(List<String> tags) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 8,
        children: [
          ...tags.map(
            (tag) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(25),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '#$tag',
                style: AppTextStyles.primaryF16W600.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sharePost(BuildContext context, PostEntity post) async {
    try {
      if (post.imageUrl != null && post.imageUrl!.isNotEmpty) {
        await _shareWithImageAndText(context, post);
      } else {
        await _shareTextOnly(context, post);
      }
      if (!context.mounted) return;
      _updateShareCount(context, post);
    } catch (e) {
      if (!context.mounted) return;
      await _shareTextOnly(context, post);
      if (!context.mounted) return;
      _updateShareCount(context, post);
    }
  }

  Future<void> _shareWithImageAndText(
    BuildContext context,
    PostEntity post,
  ) async {
    final shareText = _generateShareText(post);
    final imageFile = XFile(post.imageUrl!);
    await Share.shareXFiles(
      [imageFile],
      text: shareText,
      subject: post.title ?? 'Mi-Mine 게시글',
    );
  }

  Future<void> _shareTextOnly(BuildContext context, PostEntity post) async {
    final shareText = _generateShareText(post);
    await Share.share(shareText, subject: post.title ?? 'Mi-Mine 게시글');
  }

  void _updateShareCount(BuildContext context, PostEntity post) {
    context.read<CommunityCubit>().incrementShareCount(post.postId.toString());
  }

  String _generateShareText(PostEntity post) {
    final buffer = StringBuffer();
    buffer.writeln('✨ ${post.title}');
    buffer.writeln();
    buffer.writeln(post.description);
    buffer.writeln();
    buffer.writeln('#MiMine #게시글 #공유 #소셜 #커뮤니티');
    buffer.writeln();
    buffer.writeln('📱 Mi-Mine에서 더 많은 이야기를 확인해보세요!');
    buffer.writeln('🔗 mimine://post/${post.postId}');
    return buffer.toString();
  }

  void _showCommentBottomSheet(BuildContext context, PostEntity post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CommentBottomSheet(post: post),
    );
  }
}
