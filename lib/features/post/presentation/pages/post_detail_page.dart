import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/common/mock/comment_info_mock.dart';
import 'package:mimine/features/community/presentation/cubits/community_cubit.dart';
import 'package:mimine/features/community/presentation/cubits/community_state.dart';
import 'package:share_plus/share_plus.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/styles/app_text_styles.dart';
import 'package:mimine/common/widgets/app_dialog.dart';
import 'package:mimine/common/widgets/custom_menu_widget.dart';
import 'package:mimine/features/post/domain/entities/post_entity.dart';
import 'package:mimine/features/post/presentation/widgets/post_comment_widget.dart';

class PostDetailPage extends StatefulWidget {
  final PostEntity post;

  const PostDetailPage({super.key, required this.post});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _commentSectionKey = GlobalKey();
  final GlobalKey _menuButtonKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityCubit, CommunityState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageSection(),
                  _buildContentSection(),
                  _buildActionSection(context),
                  if (state.showComment) _buildCommentSection(context),
                ],
              ),
            ),
          ),
        );
      },
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
      actions: [_buildCustomMenuButton(context)],
    );
  }

  Widget _buildCustomMenuButton(BuildContext context) {
    return CustomMenuButton(
      buttonKey: _menuButtonKey,
      menuItems: _getMenuItems(context),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withAlpha(8),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(Icons.more_vert, color: AppColors.black, size: 20),
          ),
        ),
      ),
    );
  }

  List<CustomMenuItem> _getMenuItems(BuildContext context) {
    return [
      CustomMenuItem(
        icon: Icons.edit_rounded,
        title: '수정',
        subtitle: '게시물을 수정합니다',
        color: AppColors.primary,
        onTap: () {
          context.pop();
          context.pushNamed(RouterName.editPost, extra: widget.post);
        },
      ),
      CustomMenuItem(
        icon: Icons.delete_rounded,
        title: '삭제',
        subtitle: '게시물을 삭제합니다',
        color: AppColors.red,
        onTap: () {
          context.pop();
          _deletePost(context);
        },
      ),
    ];
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
      child: widget.post.imageUrl != null && widget.post.imageUrl!.isNotEmpty
          ? ClipRRect(
              child: Image.network(
                widget.post.imageUrl!,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.post.title ?? '제목 없음',
            style: AppTextStyles.blackF20W800LS,
          ),
          const SizedBox(height: 12),
          Text(
            widget.post.description ?? '내용 없음',
            style: AppTextStyles.blackF16H145,
          ),
        ],
      ),
    );
  }

  Widget _buildActionSection(BuildContext context) {
    return BlocBuilder<CommunityCubit, CommunityState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      icon: state.isLiked
                          ? Icons.favorite
                          : Icons.favorite_border,
                      label: '좋아요',
                      onTap: _likePost,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.comment_outlined,
                      label: '댓글',
                      onTap: _showComment,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.share,
                      label: '공유',
                      onTap: () => _sharePost(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
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

  Widget _buildCommentSection(BuildContext context) {
    final mockComments = CommentInfoMock.commentDataList;

    return Container(
      key: _commentSectionKey,
      child: PostCommentWidget(
        postId: widget.post.postId.toString(),
        comments: mockComments,
      ),
    );
  }

  void _deletePost(BuildContext context) {
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
            context.read<CommunityCubit>().deletePost(
              widget.post.postId.toString(),
            );
          },
        ),
      ],
    );
  }

  void _likePost() {
    context.read<CommunityCubit>().likePost(widget.post.postId.toString());
  }

  void _showComment() {
    context.read<CommunityCubit>().showComment();
    _scrollToCommentSection();
  }

  void _scrollToCommentSection() {
    final context = _commentSectionKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _sharePost(BuildContext context) async {
    try {
      if (widget.post.imageUrl != null && widget.post.imageUrl!.isNotEmpty) {
        await _shareWithImageAndText(context);
      } else {
        await _shareTextOnly(context);
      }
      if (!context.mounted) return;
      _updateShareCount(context);
    } catch (e) {
      if (!context.mounted) return;
      await _shareTextOnly(context);
      if (!context.mounted) return;
      _updateShareCount(context);
    }
  }

  Future<void> _shareWithImageAndText(BuildContext context) async {
    final shareText = _generateShareText();
    final imageFile = XFile(widget.post.imageUrl!);
    await Share.shareXFiles(
      [imageFile],
      text: shareText,
      subject: widget.post.title ?? 'Mi-Mine 게시글',
    );
  }

  Future<void> _shareTextOnly(BuildContext context) async {
    final shareText = _generateShareText();
    await Share.share(shareText, subject: widget.post.title ?? 'Mi-Mine 게시글');
  }

  void _updateShareCount(BuildContext context) {
    context.read<CommunityCubit>().incrementShareCount(
      widget.post.postId.toString(),
    );
  }

  String _generateShareText() {
    final buffer = StringBuffer();
    buffer.writeln('✨ ${widget.post.title}');
    buffer.writeln();
    buffer.writeln(widget.post.description);
    buffer.writeln();
    buffer.writeln('#MiMine #게시글 #공유 #소셜 #커뮤니티');
    buffer.writeln();
    buffer.writeln('📱 Mi-Mine에서 더 많은 이야기를 확인해보세요!');
    buffer.writeln('🔗 mimine://post/${widget.post.postId}');
    return buffer.toString();
  }
}
