import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/styles/app_text_styles.dart';
import 'package:mimine/common/widgets/app_toast_widget.dart';
import 'package:mimine/common/widgets/input_field_form.dart';
import 'package:mimine/common/widgets/network_image_widget.dart';
import 'package:mimine/core/utils/validators/form_validators.dart';
import 'package:mimine/features/settings/presentation/cubits/settings_cubit.dart';
import 'package:mimine/features/settings/presentation/cubits/settings_state.dart';

class EditMyProfilePage extends StatefulWidget {
  const EditMyProfilePage({super.key});

  @override
  State<EditMyProfilePage> createState() => _EditMyProfilePageState();
}

class _EditMyProfilePageState extends State<EditMyProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _mottoController = TextEditingController();
  final _todayThoughtController = TextEditingController();

  String? _selectedProfileImage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _mottoController.dispose();
    _todayThoughtController.dispose();
    super.dispose();
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
        title: Text('프로필 수정', style: AppTextStyles.blackF18W700),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: Text(
              '저장',
              style: AppTextStyles.primaryF16W600.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildProfileImageSection(),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
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
                        Text('프로필 정보', style: AppTextStyles.blackF16W700H12),
                        const SizedBox(height: 24),

                        InputFieldForm(
                          controller: _nicknameController,
                          labelText: '닉네임',
                          hintText: '닉네임을 입력해주세요',
                          validator: FormValidators.nickname,
                        ),
                        const SizedBox(height: 20),

                        InputFieldForm(
                          controller: _mottoController,
                          labelText: '좌우명',
                          hintText: '나만의 좌우명을 입력해주세요',
                          maxLines: 2,
                        ),
                        const SizedBox(height: 20),

                        InputFieldForm(
                          controller: _todayThoughtController,
                          labelText: '오늘의 생각',
                          hintText: '오늘의 생각을 자유롭게 적어보세요',
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _loadUserData() {
    final state = context.read<SettingsCubit>().state;
    if (state.userInfo != null) {
      _nicknameController.text = state.userInfo!.nickname ?? '';
      _mottoController.text = state.userInfo!.motto ?? '';
      _todayThoughtController.text = state.userInfo!.todayThought ?? '';
      _selectedProfileImage = state.userInfo!.profileImage;
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    await context.read<SettingsCubit>().updateMyProfile(
      nickname: _nicknameController.text.trim(),
      profileImage: _selectedProfileImage,
      motto: _mottoController.text.trim(),
      todayThought: _todayThoughtController.text.trim(),
    );

    if (!mounted) return;
    context.pop();
  }

  Future<void> _selectImage() async {
    final isPermissionGranted = await context
        .read<SettingsCubit>()
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
      context.read<SettingsCubit>().updateImageUrl(image.path, true);
    }
  }

  Widget _buildProfileImageSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
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
        children: [
          Text('프로필 사진', style: AppTextStyles.blackF16W700H12),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _selectImage,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[200],
                  child: _selectedProfileImage != null
                      ? NetworkImageWidget.networkImage(
                          imageUrl: _selectedProfileImage,
                        )
                      : const Icon(Icons.person, size: 60, color: Colors.grey),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 3),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text('사진을 탭하여 변경', style: AppTextStyles.greyF13),
        ],
      ),
    );
  }
}
