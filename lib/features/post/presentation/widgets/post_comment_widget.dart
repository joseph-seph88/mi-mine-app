import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/styles/app_text_styles.dart';
import 'package:mimine/core/utils/formatter/date_formatter.dart';
import 'package:mimine/features/post/domain/entities/comment_entity.dart';
import 'package:mimine/features/post/presentation/cubits/post_cubit.dart';

class PostCommentWidget extends StatefulWidget {
  final String postId;
  final List<CommentEntity> comments;

  const PostCommentWidget({
    super.key,
    required this.postId,
    required this.comments,
  });

  @override
  State<PostCommentWidget> createState() => _PostCommentWidgetState();
}

class _PostCommentWidgetState extends State<PostCommentWidget> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCommentHeader(),
          const SizedBox(height: 16),
          _buildCommentList(),
          const SizedBox(height: 16),
          _buildCommentInput(),
        ],
      ),
    );
  }

  Widget _buildCommentHeader() {
    return Row(
      children: [
        Text('댓글', style: AppTextStyles.blackF18W700),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(14),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${widget.comments.length}',
            style: AppTextStyles.greyWA204F12W400H13,
          ),
        ),
      ],
    );
  }

  Widget _buildCommentList() {
    if (widget.comments.isEmpty) {
      return _buildEmptyComments();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.comments.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final comment = widget.comments[index];
        return _buildCommentItem(comment);
      },
    );
  }

  Widget _buildEmptyComments() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 48,
            color: AppColors.grey.withAlpha(80),
          ),
          const SizedBox(height: 16),
          Text('아직 댓글이 없습니다', style: AppTextStyles.blackF14W700H12),
          const SizedBox(height: 8),
          Text('첫 번째 댓글을 작성해보세요!', style: AppTextStyles.greyWA204F12W400H13),
        ],
      ),
    );
  }

  Widget _buildCommentItem(CommentEntity comment) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.primary.withAlpha(14),
                backgroundImage: comment.profileImage.isNotEmpty
                    ? NetworkImage(comment.profileImage)
                    : null,
                child: comment.profileImage.isEmpty
                    ? Text(
                        comment.nickname.isNotEmpty
                            ? comment.nickname[0].toUpperCase()
                            : 'Mimine',
                        style: AppTextStyles.greyWA204F12W400H13,
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.nickname,
                      style: AppTextStyles.blackF14W700H12,
                    ),
                    Text(
                      DateFormatter.formatDateString(comment.createdAt),
                      style: AppTextStyles.greyWA204F12W400H13,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(comment.comment, style: AppTextStyles.blackF14W700H12),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.black.withAlpha(80)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(8),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.primary.withAlpha(14),
            child: Text('U', style: AppTextStyles.greyWA204F12W400H13),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: TextField(
              controller: _commentController,
              focusNode: _commentFocusNode,
              decoration: InputDecoration(
                hintText: '댓글을 작성해주세요..',
                hintStyle: AppTextStyles.greyF13,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: AppTextStyles.blackF14W700H12,
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: (value) => _submitComment(),
            ),
          ),

          GestureDetector(
            onTap: _submitComment,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.send, color: AppColors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  void _submitComment() {
    final commentText = _commentController.text.trim();
    if (commentText.isEmpty) return;

    context.read<PostCubit>().setCommentPost(widget.postId, commentText);

    _commentController.clear();
    _commentFocusNode.unfocus();
  }
}
