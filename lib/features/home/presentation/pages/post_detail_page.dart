import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/styles/app_text_styles.dart';
import 'package:mimine/common/widgets/network_image_widget.dart';
import 'package:mimine/features/home/domain/entites/post_entity.dart';
import 'package:mimine/features/home/presentation/cubits/home/home_cubit.dart';

class PostDetailPage extends StatelessWidget {
  final PostEntity post;

  const PostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageSection(),
              _buildContentSection(),
              _buildActionSection(context),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: AppColors.black),
        onPressed: () => context.pop(),
      ),
      title: Text('게시물', style: AppTextStyles.blackF20W800LS),
      centerTitle: true,
      actions: [
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: AppColors.black),
          onSelected: (value) {
            switch (value) {
              case 'edit':
                _editPost();
                break;
              case 'delete':
                _deletePost(context);
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, color: AppColors.primary, size: 20),
                  const SizedBox(width: 8),
                  Text('수정', style: AppTextStyles.blackF14W700H12),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: AppColors.red, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    '삭제',
                    style: AppTextStyles.blackF14W700H12.copyWith(
                      color: AppColors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageSection() {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(8),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: post.imageUrl != null && post.imageUrl!.isNotEmpty
          ? ClipRRect(
              child: Image.network(
                post.imageUrl!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.grey.withAlpha(32),
                  child: Center(
                    child: Icon(
                      Icons.image_outlined,
                      color: AppColors.grey,
                      size: 48,
                    ),
                  ),
                ),
              ),
            )
          : Container(
              color: AppColors.grey.withAlpha(32),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image_outlined, color: AppColors.grey, size: 48),
                    const SizedBox(height: 8),
                    Text('이미지가 없습니다', style: AppTextStyles.greyWA204F13W400H13),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildContentSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(8),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.title ?? '제목 없음', style: AppTextStyles.blackF24W700H135),
          const SizedBox(height: 16),
          Text(
            post.description ?? '설명이 없습니다.',
            style: AppTextStyles.blackF16H145,
          ),
          const SizedBox(height: 20),
          _buildMetaInfo(),
        ],
      ),
    );
  }

  Widget _buildMetaInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.access_time, color: AppColors.grey, size: 16),
          const SizedBox(width: 8),
          Text(
            '게시일: ${_formatDate(DateTime.now())}',
            style: AppTextStyles.greyWA204F12W400H13,
          ),
          const Spacer(),
          Icon(Icons.visibility, color: AppColors.grey, size: 16),
          const SizedBox(width: 4),
          Text('조회수 0', style: AppTextStyles.greyWA204F12W400H13),
        ],
      ),
    );
  }

  Widget _buildActionSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  icon: Icons.favorite_border,
                  label: '좋아요',
                  onTap: () => _likePost(context),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.comment_outlined,
                  label: '댓글',
                  onTap: _commentPost,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.share,
                  label: '공유',
                  onTap: _sharePost,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(8),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: AppColors.primary, size: 20),
                const SizedBox(width: 8),
                Text(label, style: AppTextStyles.blackF14W700H12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }

  void _editPost() {}

  void _deletePost(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('게시물 삭제', style: AppTextStyles.blackF18W700),
        content: Text(
          '정말로 이 게시물을 삭제하시겠습니까?',
          style: AppTextStyles.blackF16H145,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('취소', style: AppTextStyles.greyWA204F13W400H13),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (post.id != null) {
                context.read<HomeCubit>().deletePost(post.id.toString());
                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('게시물이 삭제되었습니다.'),
                    backgroundColor: AppColors.primary,
                  ),
                );
              }
            },
            child: Text(
              '삭제',
              style: AppTextStyles.blackF14W700H12.copyWith(
                color: AppColors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _likePost(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('좋아요를 눌렀습니다.'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _commentPost() {}

  void _sharePost() {}
}
