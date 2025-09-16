import 'package:flutter/material.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/styles/app_text_styles.dart';
import 'package:mimine/common/widgets/app_toast_widget.dart';
import 'package:mimine/common/widgets/back_icon_button.dart';

class AppInfoPage extends StatefulWidget {
  const AppInfoPage({super.key});

  @override
  State<AppInfoPage> createState() => _AppInfoPageState();
}

class _AppInfoPageState extends State<AppInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: BackIconButton(),
        title: Text('앱 정보', style: AppTextStyles.blackF18W700),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildAppInfoSection(),
            const SizedBox(height: 16),
            _buildLegalSection(),
            const SizedBox(height: 16),
            _buildSupportSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppInfoSection() {
    return _buildSettingsCard(
      children: [
        _buildInfoItem(icon: Icons.info_outline, title: '앱 버전', value: '1.0.0'),
        _buildDivider(),
        _buildInfoItem(icon: Icons.build_outlined, title: '빌드 번호', value: '1'),
        _buildDivider(),
        _buildInfoItem(
          icon: Icons.calendar_today_outlined,
          title: '출시일',
          value: '2025년 9월',
        ),
        _buildDivider(),
        _buildInfoItem(
          icon: Icons.storage_outlined,
          title: '앱 크기',
          value: '25.6 MB',
        ),
      ],
    );
  }

  Widget _buildLegalSection() {
    return _buildSettingsCard(
      children: [
        _buildActionItem(
          icon: Icons.description_outlined,
          title: '서비스 이용약관',
          onTap: () => _showComingSoon('서비스 이용약관'),
        ),
        _buildDivider(),
        _buildActionItem(
          icon: Icons.privacy_tip_outlined,
          title: '개인정보 처리방침',
          onTap: () => _showComingSoon('개인정보 처리방침'),
        ),
        _buildDivider(),
        _buildActionItem(
          icon: Icons.copyright_outlined,
          title: '라이선스',
          onTap: () => _showComingSoon('오픈소스 라이선스'),
        ),
        _buildDivider(),
        _buildActionItem(
          icon: Icons.gavel_outlined,
          title: '법적 고지',
          onTap: () => _showComingSoon('법적 고지'),
        ),
      ],
    );
  }

  Widget _buildSupportSection() {
    return _buildSettingsCard(
      children: [
        _buildActionItem(
          icon: Icons.help_outline,
          title: '도움말',
          onTap: () => _showComingSoon('도움말'),
        ),
        _buildDivider(),
        _buildActionItem(
          icon: Icons.bug_report_outlined,
          title: '버그 신고',
          onTap: () => _showComingSoon('버그 신고'),
        ),
        _buildDivider(),
        _buildActionItem(
          icon: Icons.feedback_outlined,
          title: '피드백 보내기',
          onTap: () => _showComingSoon('피드백 보내기'),
        ),
        _buildDivider(),
        _buildActionItem(
          icon: Icons.star_outline,
          title: '앱 평가하기',
          onTap: () => _showComingSoon('앱 평가하기'),
        ),
      ],
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
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
      child: Column(children: children),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 22, color: Colors.grey[700]),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: AppTextStyles.blackF16H145)),
          Text(value, style: AppTextStyles.greyF13),
        ],
      ),
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required String title,
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
            Expanded(child: Text(title, style: AppTextStyles.blackF16H145)),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, thickness: 1, color: Colors.grey[200]);
  }

  void _showComingSoon(String feature) {
    AppToastWidget.showInfo(context, '이 기능은 곧 추가될 예정입니다.');
  }
}
