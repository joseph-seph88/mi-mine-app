import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/common/widgets/app_dialog.dart';
import 'package:mimine/common/widgets/network_image_widget.dart';
import 'package:mimine/common/widgets/search_bar_widget.dart';
import 'package:mimine/features/community/presentation/cubits/community_cubit.dart';
import 'package:mimine/features/community/presentation/cubits/community_state.dart';
import 'package:mimine/features/post/domain/entities/post_entity.dart';
import '../../../../../common/styles/app_colors.dart';
import '../../../../../common/styles/app_text_styles.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final GlobalKey menuButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    context.read<CommunityCubit>().loadAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityCubit, CommunityState>(
      builder: (context, state) {
        List<PostEntity> postList = [];
        if (state.filterType == PostFilterType.all) {
          postList = state.allPosts ?? [];
        } else if (state.filterType == PostFilterType.myPosts) {
          postList = state.posts ?? [];
        }

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                _buildHeaderSection(context, state),
                _buildFilterSection(context, state),
                const SizedBox(height: 12),
                Expanded(
                  child: postList.isEmpty
                      ? _buildEmptyState()
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
            onPressed: () {
              context.pushNamed(RouterName.createPost);
            },
            backgroundColor: AppColors.primary,
            child: Icon(Icons.add, color: AppColors.white),
          ),
        );
      },
    );
  }
}

Widget _buildHeaderSection(BuildContext context, CommunityState state) {
  return Container(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
    height: 80,
    child: SearchBarWidget(
      hintText: "커뮤니티 검색...",
      controller: TextEditingController(),
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
            PostFilterType.all,
            state.filterType == PostFilterType.all,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildFilterButton(
            context,
            '인기 게시글',
            PostFilterType.myPosts,
            state.filterType == PostFilterType.myPosts,
          ),
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
    onTap: () {
      context.read<CommunityCubit>().setFilterType(filterType);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.grey.withAlpha(51),
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

Widget _buildEmptyState() {
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
        Text('게시글이 없습니다', style: AppTextStyles.greyF13.copyWith(fontSize: 18)),
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
        _buildPostTagSection(),
        const SizedBox(height: 16),
        _buildPostBottomSection(context, post, index),
        const SizedBox(height: 8),
      ],
    ),
  );
}

Widget _buildPostTopSection(BuildContext context, PostEntity post, int index) {
  return Padding(
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
        PopupMenuButton(
          icon: Icon(Icons.more_vert, color: AppColors.grey, size: 20),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, size: 18, color: AppColors.grey),
                  SizedBox(width: 8),
                  Text('수정', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, size: 18, color: Colors.red),
                  SizedBox(width: 8),
                  Text('삭제', style: TextStyle(color: Colors.red, fontSize: 14)),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            if (value == 'edit') {
              context.pushNamed(RouterName.editPost, extra: post);
            } else if (value == 'delete') {
              _deletePost(context, post);
            }
          },
        ),
      ],
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
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                context.read<CommunityCubit>().likePost(post.postId.toString());
              },
              icon: Icon(
                Icons.thumb_up_outlined,
                color: AppColors.grey,
                size: 22,
              ),
            ),
            Text(
              '${(index + 1) * 5}',
              style: AppTextStyles.greyF13.copyWith(fontSize: 14),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Row(
          children: [
            IconButton(
              onPressed: () {
                context.read<CommunityCubit>().showComment();
              },
              icon: Icon(
                Icons.comment_outlined,
                color: AppColors.grey,
                size: 22,
              ),
            ),
            Text(
              '${(index + 1) * 3}',
              style: AppTextStyles.greyF13.copyWith(fontSize: 14),
            ),
          ],
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () {
            context.read<CommunityCubit>().incrementShareCount(
              post.postId.toString(),
            );
          },
          icon: Icon(Icons.share_outlined, color: AppColors.grey, size: 22),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.bookmark_outline, color: AppColors.grey, size: 22),
        ),
      ],
    ),
  );
}

Widget _buildPostTagSection() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Wrap(
      spacing: 8,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(25),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '#커뮤니티',
            style: AppTextStyles.primaryF16W600.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.grey.withAlpha(25),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '#일상',
            style: AppTextStyles.greyF13.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

void _deletePost(BuildContext context, PostEntity post) {
  AppDialog.showIconDialog(
    context: context,
    title: '게시물 삭제',
    message: '정말로 이 게시물을 삭제하시겠습니까?',
    actions: [
      AppDialog.buildTextButton(text: '취소', onPressed: () => context.pop()),
      AppDialog.buildTextButton(
        text: '삭제',
        onPressed: () {
          context.pop();
          context.read<CommunityCubit>().deletePost(post.postId.toString());
        },
      ),
    ],
  );
}
