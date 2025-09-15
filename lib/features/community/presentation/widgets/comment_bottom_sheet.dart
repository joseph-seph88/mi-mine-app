import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/common/entities/comment_entity.dart';
import 'package:mimine/common/entities/post_entity.dart';
import 'package:mimine/common/entities/user_entity.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/styles/app_text_styles.dart';
import 'package:mimine/common/widgets/input_field_form.dart';
import 'package:mimine/common/widgets/network_image_widget.dart';
import 'package:mimine/core/utils/formatter/date_formatter.dart';
import 'package:mimine/features/community/presentation/cubits/community_cubit.dart';
import 'package:mimine/features/community/presentation/cubits/community_state.dart';

class CommentBottomSheet extends StatefulWidget {
  final PostEntity post;

  const CommentBottomSheet({super.key, required this.post});

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CommunityCubit>().loadComments(widget.post.postId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildBottomDragHandle(),
          _buildCommentHeader(),
          const Divider(height: 1),
          Expanded(
            child: BlocBuilder<CommunityCubit, CommunityState>(
              builder: (context, state) {
                final comments = state.comments ?? [];

                if (comments.isEmpty) {
                  return _buildEmptyComments();
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCommentItemProfileImage(comment),
                          const SizedBox(width: 12),
                          _buildCommentItemContent(comment),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(
                top: BorderSide(color: AppColors.grey.withAlpha(20), width: 1),
              ),
            ),
            child: Row(
              children: [
                BlocBuilder<CommunityCubit, CommunityState>(
                  builder: (context, state) {
                    final userData = state.userData ?? UserEntity();
                    return _buildCommentInputProfileImage(userData);
                  },
                ),
                const SizedBox(width: 12),
                _buildCommentInputField(),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomDragHandle() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.grey.withAlpha(50),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildEmptyComments() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.comment_outlined,
            size: 48,
            color: AppColors.grey.withAlpha(50),
          ),
          const SizedBox(height: 16),
          Text(
            '아직 댓글이 없습니다',
            style: AppTextStyles.greyF13.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text('첫 번째 댓글을 작성해보세요!', style: AppTextStyles.greyF13),
        ],
      ),
    );
  }

  Widget _buildCommentHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text(
            '댓글 ${widget.post.commentCount ?? 0}',
            style: AppTextStyles.blackF16H145.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.close, color: AppColors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItemProfileImage(CommentEntity comment) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: AppColors.grey.withAlpha(20),
      backgroundImage: NetworkImageWidget.getNetworkImageProvider(
        comment.profileImage,
      ),
      child: comment.profileImage.isEmpty
          ? Text(
              comment.nickname.substring(0, 1).toUpperCase(),
              style: AppTextStyles.greyF13.copyWith(
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
    );
  }

  Widget _buildCommentItemContent(CommentEntity comment) {
    final createdAt = DateFormatter.formatDateString(comment.createdAt);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                comment.nickname,
                style: AppTextStyles.greyF13.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(width: 8),
              Text(createdAt, style: AppTextStyles.greyWA178F12),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            comment.comment,
            style: AppTextStyles.greyF13.copyWith(color: AppColors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentInputProfileImage(UserEntity userData) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: AppColors.grey.withAlpha(20),
      backgroundImage: NetworkImageWidget.getNetworkImageProvider(
        userData.profileImage,
      ),
    );
  }

  Widget _buildCommentInputField() {
    return Expanded(
      child: InputFieldForm(
        controller: controller,
        hintText: '댓글을 입력하세요..',
        suffixIcon: const Icon(Icons.send, color: AppColors.grey),
        onSuffixIconPressed: () {
          if (controller.text.trim().isNotEmpty) {
            context.read<CommunityCubit>().addComment(
              widget.post.postId!,
              controller.text.trim(),
            );
            controller.clear();
          }
        },
        maxLines: null,
        textInputAction: TextInputAction.send,
      ),
    );
  }

}
