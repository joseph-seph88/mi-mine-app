import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/common/entities/user_entity.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/styles/app_text_styles.dart';
import 'package:mimine/common/widgets/network_image_widget.dart';
import 'package:mimine/features/settings/presentation/cubits/settings_cubit.dart';
import 'package:mimine/features/settings/presentation/cubits/settings_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsCubit>().loadMyProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => context.pushNamed(RouterName.editMyProfile),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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
                      child: Column(
                        children: [
                          _buildProfileSection(state.userInfo),
                          const SizedBox(height: 24),
                          _buildMottoSection(state.userInfo),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildActivityMetrics(state.userInfo),
                  const SizedBox(height: 16),
                  _buildMenuSection(),
                  const SizedBox(height: 16),
                  _buildRecentActivitySection(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileSection(UserEntity? userInfo) {
    return Row(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[200],
              child: NetworkImageWidget.networkImage(
                imageUrl: userInfo?.profileImage,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 2),
                ),
                child: const Icon(Icons.edit, size: 16, color: AppColors.white),
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userInfo?.nickname ?? '',
                style: AppTextStyles.blackF20W800LS,
              ),
              const SizedBox(height: 6),
              Text(userInfo?.email ?? '', style: AppTextStyles.greyF13),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMottoSection(UserEntity? userInfo) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.task_alt_outlined, color: Colors.blue[800], size: 20),
              const SizedBox(width: 8),
              Text(
                userInfo?.motto ?? '',
                style: AppTextStyles.mottoF16WB,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            userInfo?.todayThought ?? '',
            style: AppTextStyles.todayThoughtF14H14,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityMetrics(UserEntity? userInfo) {
    final contentsCount = userInfo?.contentsCount ?? 0;
    final friendsCount = userInfo?.friends?.length ?? 0;
    final followersCount = userInfo?.followers?.length ?? 0;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.symmetric(vertical: 16),
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
          _buildMetricItem('내 게시글', '$contentsCount개'),
          _buildDivider(),
          _buildMetricItem('내 친구', '$friendsCount명'),
          _buildDivider(),
          _buildMetricItem('내 팔로워', '$followersCount명'),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String count) {
    return Expanded(
      child: Column(
        children: [
          Text(count, style: AppTextStyles.blackF18W700),
          const SizedBox(height: 6),
          Text(label, style: AppTextStyles.greyF13),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 40, width: 1, color: Colors.grey[300]);
  }

  Widget _buildMenuSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
      child: Column(
        children: [
          _buildMenuItem(
            '내 활동',
            Icons.work_outline,
            onTap: () => context.pushNamed(RouterName.myActivity),
          ),
          _buildDividerLine(),
          _buildMenuItem(
            '연락처',
            Icons.contact_mail_outlined,
            onTap: () => context.pushNamed(RouterName.contact),
          ),
          _buildDividerLine(),
          _buildMenuItem(
            'SNS 링크',
            Icons.share_outlined,
            onTap: () => context.pushNamed(RouterName.snsLinks),
          ),
          _buildDividerLine(),
          _buildMenuItem(
            '알림 설정',
            Icons.notifications_outlined,
            onTap: () => context.pushNamed(RouterName.notificationSettings),
          ),
          _buildDividerLine(),
          _buildMenuItem(
            '개인정보 설정',
            Icons.privacy_tip_outlined,
            onTap: () => context.pushNamed(RouterName.privacySettings),
          ),
          _buildDividerLine(),
          _buildMenuItem(
            '앱 정보',
            Icons.info_outline,
            onTap: () => context.pushNamed(RouterName.appInfo),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 22, color: Colors.grey[700]),
            const SizedBox(width: 16),
            Expanded(child: Text(title, style: AppTextStyles.blackF16H145)),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildDividerLine() {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 56,
      color: Colors.grey[200],
    );
  }

  Widget _buildRecentActivitySection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('최근 활동', style: AppTextStyles.blackF18W700),
              TextButton(
                onPressed: () {},
                child: Text('전체보기', style: AppTextStyles.viewAllButtonF14),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildActivityItem('새 게시글 업로드', '여행지 추가', '2시간 전'),
          const SizedBox(height: 16),
          _buildActivityItem('금주 미션 업데이트', '맛집 리스트 추가', '1일 전'),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String title, String description, String time) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.code, color: Colors.blue[600], size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.activityTitleF16W600),
                const SizedBox(height: 4),
                Text(description, style: AppTextStyles.activityDescriptionF14),
                const SizedBox(height: 4),
                Text(time, style: AppTextStyles.activityTimeF12),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
        ],
      ),
    );
  }
}
