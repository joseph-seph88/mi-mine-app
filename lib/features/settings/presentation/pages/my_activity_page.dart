import 'package:flutter/material.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/styles/app_text_styles.dart';
import 'package:mimine/common/widgets/app_toast_widget.dart';
import 'package:mimine/common/widgets/back_icon_button.dart';
import 'package:mimine/features/settings/domain/entites/activity_item.dart';
import 'package:mimine/features/settings/setting_mock_constant.dart';

class MyActivityPage extends StatefulWidget {
  const MyActivityPage({super.key});

  @override
  State<MyActivityPage> createState() => _MyActivityPageState();
}

class _MyActivityPageState extends State<MyActivityPage> {
  List<ActivityItem> _recentActivities = [];

  @override
  void initState() {
    super.initState();
    _recentActivities = SettingMockConstant.recentActivities;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: BackIconButton(),
        title: Text('내 활동', style: AppTextStyles.blackF18W700),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => _showComingSoon(),
            child: Text('전체보기', style: AppTextStyles.primaryF16W600),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStatsSection(),
            const SizedBox(height: 16),
            _buildRecentActivitySection(),
            const SizedBox(height: 16),
            _buildQuickActionsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
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
          Text('활동 통계', style: AppTextStyles.blackF16W700H12),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildStatItem('게시글', '12', Icons.article_outlined, Colors.blue),
              _buildDivider(),
              _buildStatItem('댓글', '48', Icons.comment_outlined, Colors.green),
              _buildDivider(),
              _buildStatItem('좋아요', '156', Icons.favorite_outline, Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivitySection() {
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
          Text('최근 활동', style: AppTextStyles.blackF16W700H12),
          const SizedBox(height: 16),
          ..._recentActivities.map((activity) => _buildActivityItem(activity)),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection() {
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
          Text('빠른 작업', style: AppTextStyles.blackF16W700H12),
          const SizedBox(height: 16),
          _buildActionItem(
            icon: Icons.download_outlined,
            title: '데이터 내보내기',
            subtitle: '내 활동 데이터를 다운로드합니다',
            onTap: () => _showComingSoon(),
          ),
          _buildDivider(),
          _buildActionItem(
            icon: Icons.history_outlined,
            title: '활동 기록 보기',
            subtitle: '전체 활동 기록을 확인합니다',
            onTap: () => _showComingSoon(),
          ),
          _buildDivider(),
          _buildActionItem(
            icon: Icons.settings_outlined,
            title: '활동 알림 설정',
            subtitle: '활동 관련 알림을 관리합니다',
            onTap: () => _showComingSoon(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String count,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withAlpha(10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(count, style: AppTextStyles.blackF18W700),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.greyF13),
        ],
      ),
    );
  }

  Widget _buildActivityItem(ActivityItem activity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
              color: activity.color.withAlpha(10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(activity.icon, color: activity.color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity.title, style: AppTextStyles.activityTitleF16W600),
                const SizedBox(height: 4),
                Text(
                  activity.description,
                  style: AppTextStyles.activityDescriptionF14,
                ),
                const SizedBox(height: 4),
                Text(activity.time, style: AppTextStyles.activityTimeF12),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
        ],
      ),
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 22, color: Colors.grey[700]),
            const SizedBox(width: 16),
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
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 40, width: 1, color: Colors.grey[300]);
  }

  void _showComingSoon() {
    AppToastWidget.showInfo(context, '이 기능은 곧 추가될 예정입니다.');
  }
}
