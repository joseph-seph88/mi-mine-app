import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/styles/app_text_styles.dart';
import 'package:mimine/common/widgets/app_toast_widget.dart';
import 'package:mimine/common/widgets/back_icon_button.dart';

class PrivacySettingsPage extends StatefulWidget {
  const PrivacySettingsPage({super.key});

  @override
  State<PrivacySettingsPage> createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {
  bool _profileVisibility = true;
  bool _showEmail = false;
  bool _showLocation = true;
  bool _allowSearch = true;
  bool _allowFriendRequests = true;
  bool _dataCollection = true;
  bool _analytics = true;
  bool _crashReports = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: BackIconButton(),
        title: Text('개인정보 설정', style: AppTextStyles.blackF18W700),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfilePrivacySection(),
            const SizedBox(height: 16),
            _buildDataSharingSection(),
            const SizedBox(height: 16),
            _buildDataCollectionSection(),
            const SizedBox(height: 16),
            _buildAccountSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePrivacySection() {
    return _buildSettingsCard(
      title: '프로필 공개 설정',
      children: [
        _buildSwitchItem(
          title: '프로필 공개',
          subtitle: '다른 사용자가 내 프로필을 볼 수 있습니다',
          value: _profileVisibility,
          onChanged: (value) => setState(() => _profileVisibility = value),
        ),
        _buildDivider(),
        _buildSwitchItem(
          title: '이메일 공개',
          subtitle: '프로필에 이메일을 표시합니다',
          value: _showEmail,
          onChanged: (value) => setState(() => _showEmail = value),
        ),
        _buildDivider(),
        _buildSwitchItem(
          title: '위치 정보 공개',
          subtitle: '게시글에 위치 정보를 포함합니다',
          value: _showLocation,
          onChanged: (value) => setState(() => _showLocation = value),
        ),
        _buildDivider(),
        _buildSwitchItem(
          title: '검색 허용',
          subtitle: '다른 사용자가 나를 검색할 수 있습니다',
          value: _allowSearch,
          onChanged: (value) => setState(() => _allowSearch = value),
        ),
        _buildDivider(),
        _buildSwitchItem(
          title: '친구 요청 허용',
          subtitle: '다른 사용자가 친구 요청을 보낼 수 있습니다',
          value: _allowFriendRequests,
          onChanged: (value) => setState(() => _allowFriendRequests = value),
        ),
      ],
    );
  }

  Widget _buildDataSharingSection() {
    return _buildSettingsCard(
      title: '데이터 공유',
      children: [
        _buildActionItem(
          icon: Icons.share_outlined,
          title: '데이터 내보내기',
          subtitle: '내 데이터를 다운로드합니다',
          onTap: () => _showComingSoon('데이터 내보내기'),
        ),
        _buildDivider(),
        _buildActionItem(
          icon: Icons.delete_outline,
          title: '데이터 삭제 요청',
          subtitle: '계정과 모든 데이터를 삭제합니다',
          onTap: () => _showDeleteDataDialog(),
        ),
      ],
    );
  }

  Widget _buildDataCollectionSection() {
    return _buildSettingsCard(
      title: '데이터 수집',
      children: [
        _buildSwitchItem(
          title: '사용 데이터 수집',
          subtitle: '앱 사용 패턴을 분석합니다',
          value: _dataCollection,
          onChanged: (value) => setState(() => _dataCollection = value),
        ),
        _buildDivider(),
        _buildSwitchItem(
          title: '분석 데이터',
          subtitle: '앱 개선을 위한 분석 데이터를 수집합니다',
          value: _analytics,
          onChanged: (value) => setState(() => _analytics = value),
        ),
        _buildDivider(),
        _buildSwitchItem(
          title: '크래시 리포트',
          subtitle: '앱 오류 정보를 자동으로 전송합니다',
          value: _crashReports,
          onChanged: (value) => setState(() => _crashReports = value),
        ),
      ],
    );
  }

  Widget _buildAccountSection() {
    return _buildSettingsCard(
      title: '계정 관리',
      children: [
        _buildActionItem(
          icon: Icons.lock_outline,
          title: '비밀번호 변경',
          subtitle: '계정 비밀번호를 변경합니다',
          onTap: () => _showComingSoon('비밀번호 변경'),
        ),
        _buildDivider(),
        _buildActionItem(
          icon: Icons.phone_outlined,
          title: '연락처 정보',
          subtitle: '전화번호 및 이메일 관리',
          onTap: () => _showComingSoon('연락처 정보'),
        ),
        _buildDivider(),
        _buildActionItem(
          icon: Icons.security_outlined,
          title: '보안 설정',
          subtitle: '2단계 인증 및 보안 옵션',
          onTap: () => _showComingSoon('보안 설정'),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Divider(height: 1, thickness: 1, color: Colors.grey[200]),
    );
  }

  void _showComingSoon(String feature) {
    AppToastWidget.showInfo(context, '이 기능은 곧 추가될 예정입니다.');
  }

  void _showDeleteDataDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('데이터 삭제 요청'),
        content: const Text('계정과 모든 데이터를 삭제하면 복구할 수 없습니다.\n정말로 삭제하시겠습니까?'),
        backgroundColor: AppColors.white,
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('취소')),
          TextButton(
            onPressed: () {
              context.pop();
              _showComingSoon('데이터 삭제 요청');
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }
}
