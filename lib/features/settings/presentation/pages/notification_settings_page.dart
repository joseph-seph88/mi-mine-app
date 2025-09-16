import 'package:flutter/material.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/styles/app_text_styles.dart';
import 'package:mimine/common/widgets/back_icon_button.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _friendRequests = true;
  bool _comments = true;
  bool _likes = false;
  bool _mentions = true;
  bool _newPosts = true;
  bool _weeklyDigest = false;
  bool _marketingEmails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: BackIconButton(),
        title: Text('알림 설정', style: AppTextStyles.blackF18W700),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildNotificationSection(),
            const SizedBox(height: 16),
            _buildSocialSection(),
            const SizedBox(height: 16),
            _buildContentSection(),
            const SizedBox(height: 16),
            _buildMarketingSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSection() {
    return _buildSettingsCard(
      title: '알림',
      children: [
        _buildSwitchItem(
          title: '푸시 알림',
          subtitle: '앱에서 알림을 받습니다',
          value: _pushNotifications,
          onChanged: (value) => setState(() => _pushNotifications = value),
        ),
        _buildDivider(),
        _buildSwitchItem(
          title: '이메일 알림',
          subtitle: '이메일로 알림을 받습니다',
          value: _emailNotifications,
          onChanged: (value) => setState(() => _emailNotifications = value),
        ),
      ],
    );
  }

  Widget _buildSocialSection() {
    return _buildSettingsCard(
      title: '소셜',
      children: [
        _buildSwitchItem(
          title: '친구 요청',
          subtitle: '새로운 친구 요청 알림',
          value: _friendRequests,
          onChanged: (value) => setState(() => _friendRequests = value),
        ),
        _buildDivider(),
        _buildSwitchItem(
          title: '댓글',
          subtitle: '내 게시글에 댓글이 달렸을 때',
          value: _comments,
          onChanged: (value) => setState(() => _comments = value),
        ),
        _buildDivider(),
        _buildSwitchItem(
          title: '좋아요',
          subtitle: '내 게시글에 좋아요를 받았을 때',
          value: _likes,
          onChanged: (value) => setState(() => _likes = value),
        ),
        _buildDivider(),
        _buildSwitchItem(
          title: '멘션',
          subtitle: '다른 사용자가 나를 언급했을 때',
          value: _mentions,
          onChanged: (value) => setState(() => _mentions = value),
        ),
      ],
    );
  }

  Widget _buildContentSection() {
    return _buildSettingsCard(
      title: '콘텐츠',
      children: [
        _buildSwitchItem(
          title: '새 게시글',
          subtitle: '팔로우한 사용자의 새 게시글',
          value: _newPosts,
          onChanged: (value) => setState(() => _newPosts = value),
        ),
        _buildDivider(),
        _buildSwitchItem(
          title: '주간 요약',
          subtitle: '주간 활동 요약 이메일',
          value: _weeklyDigest,
          onChanged: (value) => setState(() => _weeklyDigest = value),
        ),
      ],
    );
  }

  Widget _buildMarketingSection() {
    return _buildSettingsCard(
      title: '마케팅',
      children: [
        _buildSwitchItem(
          title: '마케팅 이메일',
          subtitle: '프로모션 및 업데이트 소식',
          value: _marketingEmails,
          onChanged: (value) => setState(() => _marketingEmails = value),
        ),
      ],
    );
  }

  Widget _buildSettingsCard({
    required String title,
    required List<Widget> children,
  }) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.blackF16W700H12),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchItem({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.blackF16H145),
              const SizedBox(height: 4),
              Text(subtitle, style: AppTextStyles.greyF13),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary,
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Divider(height: 1, thickness: 1, color: Colors.grey[200]),
    );
  }
}
