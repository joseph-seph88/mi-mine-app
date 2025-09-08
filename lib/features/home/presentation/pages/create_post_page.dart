import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mimine/common/enums/permission_status_type.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/styles/app_text_styles.dart';
import 'package:mimine/common/widgets/app_snack_bar.dart';
import 'package:mimine/common/widgets/network_image_widget.dart';
import 'package:mimine/features/home/presentation/widgets/home_permission_dialog.dart';
import 'package:mimine/features/home/domain/entites/home_entity.dart';
import 'package:mimine/features/home/presentation/cubits/home/home_cubit.dart';
import 'package:mimine/features/home/presentation/cubits/home/home_state.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  String _imageUrl = '';

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
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.permissionStatusType ==
                PermissionStatusType.permissionPermanentlyDenied ||
            state.permissionStatusType ==
                PermissionStatusType.permissionDenied) {
          HomePermissionDialog.show(context, state);
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
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return _buildHeaderSection(state.homeData);
                  },
                ),
                const SizedBox(height: 24),
                _buildImageUploadSection(),
                const SizedBox(height: 24),
                _buildTitleSection(),
                const SizedBox(height: 20),
                _buildDescriptionSection(),
                const SizedBox(height: 32),
                _buildPublishButton(),
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
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text('새 게시글', style: AppTextStyles.blackF20W800LS),
      centerTitle: true,
      actions: [
        TextButton(
          onPressed:
              _titleController.text.isNotEmpty &&
                  _descriptionController.text.isNotEmpty
              ? _publishPost
              : null,
          child: Text(
            '게시',
            style: TextStyle(
              color:
                  _titleController.text.isNotEmpty &&
                      _descriptionController.text.isNotEmpty
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

  Widget _buildHeaderSection(HomeEntity? homeData) {
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
              homeData?.profileImage,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('새로운 작품을 공유해보세요', style: AppTextStyles.blackF16W700H12),
                const SizedBox(height: 4),
                Text(
                  '당신의 창작물을 세상과 나누어보세요',
                  style: AppTextStyles.greyWA204F13W400H13,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageUploadSection() {
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: Column(
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
                Text('이미지 추가', style: AppTextStyles.blackF16W700H12),
                const SizedBox(height: 4),
                Text(
                  '클릭하여 사진을 선택하세요',
                  style: AppTextStyles.greyWA204F13W400H13,
                ),
              ],
            ),
          ),
        ),
      ),
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

  Widget _buildPublishButton() {
    final isEnabled =
        _titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty;

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
            onTap: isEnabled ? _publishPost : null,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                '게시하기',
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

  Future<void> _selectImage() async {
    final isPermissionGranted = await context
        .read<HomeCubit>()
        .checkRequestPermission();

    if (!mounted) return;

    if (!isPermissionGranted) {
      AppSnackBar.showError(context, '이미지 업로드를 위해 카메라 및 갤러리 접근 권한이 필요합니다.');
      return;
    }

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (image != null) {
      _imageUrl = image.path;
    }
  }

  void _publishPost() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      context.read<HomeCubit>().createPost(
        _titleController.text,
        _descriptionController.text,
        _imageUrl,
      );

      context.pop();
    }
  }
}
