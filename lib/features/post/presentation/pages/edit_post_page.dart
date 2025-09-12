import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mimine/common/entities/user_entity.dart';
import 'package:mimine/common/enums/permission_status_type.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/styles/app_text_styles.dart';
import 'package:mimine/common/widgets/app_toast_widget.dart';
import 'package:mimine/common/widgets/network_image_widget.dart';
import 'package:mimine/features/post/domain/entities/post_entity.dart';
import 'package:mimine/features/community/presentation/cubits/community_cubit.dart';
import 'package:mimine/features/community/presentation/cubits/community_state.dart';
import 'package:mimine/features/post/presentation/widgets/post_permission_dialog.dart';

class EditPostPage extends StatefulWidget {
  final PostEntity post;

  const EditPostPage({super.key, required this.post});

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    _titleController.text = widget.post.title ?? '';
    _descriptionController.text = widget.post.description ?? '';
    context.read<CommunityCubit>().initializePostData(widget.post);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommunityCubit, CommunityState>(
      listener: (context, state) {
        if (state.permissionStatusType ==
                PermissionStatusType.permissionPermanentlyDenied ||
            state.permissionStatusType ==
                PermissionStatusType.permissionDenied) {
          PostPermissionDialog.show(context, state);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: _buildAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<CommunityCubit, CommunityState>(
                  builder: (context, state) {
                    return _buildHeaderSection(state.userData);
                  },
                ),
                const SizedBox(height: 24),
                _buildImageEditSection(),
                const SizedBox(height: 24),
                _buildTitleSection(),
                const SizedBox(height: 20),
                _buildDescriptionSection(),
                const SizedBox(height: 32),
                _buildUpdateButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: AppColors.black),
        onPressed: () => context.pop(),
      ),
      title: Text('게시글 수정', style: AppTextStyles.blackF20W800LS),
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: _hasChanges() ? _updatePost : null,
          child: Text(
            '수정',
            style: TextStyle(
              color: _hasChanges()
                  ? AppColors.primary
                  : AppColors.grey.withAlpha(128),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderSection(UserEntity? userData) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.grey.withAlpha(32),
            backgroundImage: NetworkImageWidget.getNetworkImageProvider(
              userData?.profileImage,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('작품을 수정해보세요', style: AppTextStyles.blackF16W700H12),
                const SizedBox(height: 4),
                Text(
                  '변경사항을 저장하여 업데이트하세요',
                  style: AppTextStyles.greyWA204F13W400H13,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageEditSection() {
    return BlocBuilder<CommunityCubit, CommunityState>(
      builder: (context, state) {
        final imageUrl = state.pickedImageUrl;
        final hasImageChanged = state.hasImageChanged;

        return Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.grey.withAlpha(51),
              width: 2,
              style: BorderStyle.solid,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withAlpha(4),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: _selectImage,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: (imageUrl ?? '').isNotEmpty
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: hasImageChanged
                                ? Image.file(
                                    File(imageUrl!),
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            _buildImagePlaceholder(),
                                  )
                                : Image.network(
                                    imageUrl!,
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            _buildImagePlaceholder(),
                                  ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.black.withAlpha(128),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                Icons.edit,
                                color: AppColors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      )
                    : _buildImagePlaceholder(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImagePlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(25),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.add_photo_alternate_outlined,
            color: AppColors.primary,
            size: 32,
          ),
        ),
        const SizedBox(height: 12),
        Text('이미지 변경', style: AppTextStyles.blackF16W700H12),
        const SizedBox(height: 4),
        Text('클릭하여 사진을 선택하세요', style: AppTextStyles.greyWA204F13W400H13),
      ],
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('제목', style: AppTextStyles.blackF16W700H12),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withAlpha(4),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _titleController,
            focusNode: _titleFocusNode,
            decoration: InputDecoration(
              hintText: '작품의 제목을 입력하세요',
              hintStyle: AppTextStyles.greyWA204F13W400H13,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            style: AppTextStyles.blackF16H145,
            maxLines: 1,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => _descriptionFocusNode.requestFocus(),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('설명', style: AppTextStyles.blackF16W700H12),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withAlpha(4),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _descriptionController,
            focusNode: _descriptionFocusNode,
            decoration: InputDecoration(
              hintText: '작품에 대한 설명을 자유롭게 작성해보세요..',
              hintStyle: AppTextStyles.greyWA204F13W400H13,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            style: AppTextStyles.blackF16H145,
            maxLines: 6,
            textInputAction: TextInputAction.done,
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateButton() {
    final isEnabled = _hasChanges();

    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: isEnabled ? AppColors.primary : AppColors.grey.withAlpha(128),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(51),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: isEnabled ? _updatePost : null,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                '수정하기',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _hasChanges() {
    return _titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        (_titleController.text != widget.post.title ||
            _descriptionController.text != widget.post.description ||
            context.read<CommunityCubit>().state.hasImageChanged);
  }

  Future<void> _selectImage() async {
    final isPermissionGranted = await context
        .read<CommunityCubit>()
        .checkRequestPermission();

    if (!mounted) return;

    if (!isPermissionGranted) {
      AppToastWidget.showInfo(context, '이미지 업로드를 위해 카메라 및 갤러리 접근 권한이 필요합니다.');
      return;
    }

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (image != null && mounted) {
      context.read<CommunityCubit>().updateImageUrl(image.path, true);
    }
  }

  void _updatePost() {
    if (_hasChanges()) {
      final state = context.read<CommunityCubit>().state;
      context.read<CommunityCubit>().updatePost(
        widget.post.postId.toString(),
        _titleController.text,
        _descriptionController.text,
        state.hasImageChanged
            ? state.pickedImageUrl ?? ''
            : widget.post.imageUrl ?? '',
      );

      AppToastWidget.showSuccess(context, '게시글이 성공적으로 수정되었습니다.');
      context.pop();
    }
  }
}
