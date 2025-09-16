import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/styles/app_text_styles.dart';
import 'package:mimine/common/widgets/app_toast_widget.dart';
import 'package:mimine/common/widgets/back_icon_button.dart';
import 'package:mimine/features/settings/domain/entites/snslink_entity.dart';
import 'package:mimine/features/settings/setting_mock_constant.dart';

class SnsLinksPage extends StatefulWidget {
  const SnsLinksPage({super.key});

  @override
  State<SnsLinksPage> createState() => _SnsLinksPageState();
}

class _SnsLinksPageState extends State<SnsLinksPage> {
  List<SnsLink> _snsLinks = [];

  @override
  void initState() {
    super.initState();
    _snsLinks = SettingMockConstant.snsLinkMockList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: BackIconButton(),
        title: Text('SNS 링크', style: AppTextStyles.blackF18W700),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppColors.primary),
            onPressed: () => _showComingSoon(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSnsStatsSection(),
            const SizedBox(height: 16),
            _buildSnsLinksSection(),
            const SizedBox(height: 16),
            _buildSnsSettingsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSnsStatsSection() {
    final connectedCount = _snsLinks.where((link) => link.isConnected).length;

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
          Text('SNS 연결 상태', style: AppTextStyles.blackF16W700H12),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildStatItem(
                '연결된 계정',
                '$connectedCount개',
                Icons.link_outlined,
                Colors.green,
              ),
              _buildDivider(),
              _buildStatItem(
                '전체 계정',
                '${_snsLinks.length}개',
                Icons.account_circle_outlined,
                Colors.blue,
              ),
              _buildDivider(),
              _buildStatItem(
                '마지막 업데이트',
                '2일 전',
                Icons.update_outlined,
                Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSnsLinksSection() {
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
          Text('연결된 SNS 계정', style: AppTextStyles.blackF16W700H12),
          const SizedBox(height: 16),
          ..._snsLinks.map((link) => _buildSnsLinkItem(link)),
        ],
      ),
    );
  }

  Widget _buildSnsSettingsSection() {
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
          Text('SNS 설정', style: AppTextStyles.blackF16W700H12),
          const SizedBox(height: 16),
          _buildActionItem(
            icon: Icons.sync_outlined,
            title: 'SNS 동기화',
            subtitle: '연결된 계정과 데이터 동기화',
            onTap: () => _showComingSoon(),
          ),
          _buildDivider(),
          _buildActionItem(
            icon: Icons.share_outlined,
            title: '자동 공유 설정',
            subtitle: '게시글 자동 공유 옵션',
            onTap: () => _showComingSoon(),
          ),
          _buildDivider(),
          _buildActionItem(
            icon: Icons.privacy_tip_outlined,
            title: '공개 범위 설정',
            subtitle: 'SNS 공유 공개 범위 관리',
            onTap: () => _showComingSoon(),
          ),
          _buildDivider(),
          _buildActionItem(
            icon: Icons.analytics_outlined,
            title: 'SNS 분석',
            subtitle: 'SNS 활동 분석 및 통계',
            onTap: () => _showComingSoon(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
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
          Text(value, style: AppTextStyles.blackF18W700),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.greyF13),
        ],
      ),
    );
  }

  Widget _buildSnsLinkItem(SnsLink link) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: link.isConnected
              ? link.color.withAlpha(30)
              : Colors.grey[200]!,
        ),
        borderRadius: BorderRadius.circular(12),
        color: link.isConnected ? link.color.withAlpha(5) : Colors.grey[50],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: link.color.withAlpha(10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(link.icon, color: link.color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(link.platform, style: AppTextStyles.blackF16H145),
                    const SizedBox(width: 8),
                    if (link.isConnected)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '연결됨',
                          style: AppTextStyles.whiteF20WB.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '미연결',
                          style: AppTextStyles.whiteF20WB.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(link.username, style: AppTextStyles.greyF13),
                const SizedBox(height: 2),
                Text(link.url, style: AppTextStyles.greyF13),
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) => _handleSnsAction(value, link),
            itemBuilder: (context) => [
              if (link.isConnected) ...[
                const PopupMenuItem(value: 'disconnect', child: Text('연결 해제')),
                const PopupMenuItem(value: 'edit', child: Text('편집')),
              ] else
                const PopupMenuItem(value: 'connect', child: Text('연결')),
              const PopupMenuItem(value: 'delete', child: Text('삭제')),
            ],
            child: Icon(Icons.more_vert, color: Colors.grey[600]),
          ),
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

  void _handleSnsAction(String action, SnsLink link) {
    switch (action) {
      case 'connect':
        _showComingSoon();
        break;
      case 'disconnect':
        _showDisconnectDialog(link);
        break;
      case 'edit':
        _showComingSoon();
        break;
      case 'delete':
        _showDeleteSnsDialog(link);
        break;
    }
  }

  void _showDisconnectDialog(SnsLink link) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('SNS 연결 해제'),
        content: Text('${link.platform} 계정 연결을 해제하시겠습니까?'),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('취소')),
          TextButton(
            onPressed: () {
              context.pop();
              _showComingSoon();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('해제'),
          ),
        ],
      ),
    );
  }

  void _showDeleteSnsDialog(SnsLink link) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('SNS 계정 삭제'),
        content: Text('${link.platform} 계정을 삭제하시겠습니까?'),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('취소')),
          TextButton(
            onPressed: () {
              context.pop();
              _showComingSoon();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }

  void _showComingSoon() {
    AppToastWidget.showInfo(context, '이 기능은 곧 추가될 예정입니다.');
  }
}
