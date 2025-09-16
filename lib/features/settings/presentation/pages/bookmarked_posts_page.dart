import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/common/entities/post_entity.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/styles/app_text_styles.dart';
import 'package:mimine/common/widgets/network_image_widget.dart';
import 'package:mimine/features/community/presentation/cubits/community_cubit.dart';
import 'package:mimine/features/community/presentation/cubits/community_state.dart';

class BookmarkedPostsPage extends StatefulWidget {
  const BookmarkedPostsPage({super.key});

  @override
  State<BookmarkedPostsPage> createState() => _BookmarkedPostsPageState();
}

class _BookmarkedPostsPageState extends State<BookmarkedPostsPage> {
  @override
  void initState() {
    super.initState();
    context.read<CommunityCubit>().loadAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
          onPressed: () => context.pop(),
        ),
        title: Text('찜한 게시물', style: AppTextStyles.blackF18W700),
        centerTitle: true,
      ),
      body: BlocBuilder<CommunityCubit, CommunityState>(
        builder: (context, state) {
          if (state.allPosts == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final bookmarkedPosts = (state.allPosts ?? [])
              .where((post) => state.bookMarkedPostIds.contains(post.postId))
              .toList();

          if (bookmarkedPosts.isEmpty) {
            return _buildEmptyState();
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<CommunityCubit>().loadAllPosts();
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookmarkedPosts.length,
              itemBuilder: (context, index) {
                return _buildPostCard(bookmarkedPosts[index], state);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_outline, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            '찜한 게시물이 없습니다',
            style: AppTextStyles.blackF18W700.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text('마음에 드는 게시물을 찜해보세요!', style: AppTextStyles.greyF13),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.goNamed(RouterName.community),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              '커뮤니티 둘러보기',
              style: AppTextStyles.primaryF16W600.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(PostEntity post, CommunityState state) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(8),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _navigateToPostDetail(post),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPostHeader(post, state),
            if (post.imageUrl != null && post.imageUrl!.isNotEmpty)
              _buildPostImage(post),
            _buildPostContent(post),
            _buildPostActions(post, state),
          ],
        ),
      ),
    );
  }

  Widget _buildPostHeader(PostEntity post, CommunityState state) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[200],
            child: const Icon(Icons.person, size: 24, color: Colors.grey),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('익명', style: AppTextStyles.blackF14W700H12),
                const SizedBox(height: 4),
                Text(
                  _formatTimeAgo(post.createdAt),
                  style: AppTextStyles.greyF13,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => context.read<CommunityCubit>().setIsBookMarked(
              post.postId.toString(),
            ),
            icon: Icon(Icons.bookmark, color: AppColors.primary, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildPostImage(PostEntity post) {
    return Container(
      width: double.infinity,
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[100],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: NetworkImageWidget.networkImage(imageUrl: post.imageUrl),
      ),
    );
  }

  Widget _buildPostContent(PostEntity post) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title ?? '',
            style: AppTextStyles.blackF16W700H12,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            post.description ?? '',
            style: AppTextStyles.blackF16H145,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          if (post.tags != null && post.tags!.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildPostTags(post.tags!),
          ],
        ],
      ),
    );
  }

  Widget _buildPostTags(List<String> tags) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: tags
          .take(3)
          .map(
            (tag) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '#$tag',
                style: AppTextStyles.primaryF16W600.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildPostActions(PostEntity post, CommunityState state) {
    final isLiked = state.likedPostIds.contains(post.postId);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: [
          _buildActionButton(
            icon: isLiked ? Icons.favorite : Icons.favorite_outline,
            color: isLiked ? Colors.red : Colors.grey[600]!,
            count: post.likeCount ?? 0,
            onTap: () =>
                context.read<CommunityCubit>().likePost(post.postId.toString()),
          ),
          const SizedBox(width: 16),
          _buildActionButton(
            icon: Icons.chat_bubble_outline,
            color: Colors.grey[600]!,
            count: post.commentCount ?? 0,
            onTap: () => _navigateToPostDetail(post),
          ),
          const SizedBox(width: 16),
          _buildActionButton(
            icon: Icons.share_outlined,
            color: Colors.grey[600]!,
            count: post.shareCount ?? 0,
            onTap: () {},
          ),
          const Spacer(),
          Text(_formatTimeAgo(post.createdAt), style: AppTextStyles.greyF13),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required int count,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 4),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPostDetail(PostEntity post) {
    context.pushNamed(
      RouterName.postDetail,
      pathParameters: {'postId': post.postId.toString()},
      extra: {
        'title': post.title,
        'description': post.description,
        'imageUrl': post.imageUrl,
      },
    );
  }

  String _formatTimeAgo(Object? dateTime) {
    if (dateTime == null) return '';

    DateTime? parsedDateTime;
    if (dateTime is DateTime) {
      parsedDateTime = dateTime;
    } else if (dateTime is String) {
      try {
        parsedDateTime = DateTime.parse(dateTime);
      } catch (e) {
        return '';
      }
    } else {
      return '';
    }

    final now = DateTime.now();
    final difference = now.difference(parsedDateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}일 전';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }
}
