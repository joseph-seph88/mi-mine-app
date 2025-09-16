import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/styles/app_text_styles.dart';
import 'package:mimine/common/widgets/app_toast_widget.dart';
import 'package:mimine/common/widgets/back_icon_button.dart';
import 'package:mimine/features/settings/domain/entites/contact_item_entity.dart';
import 'package:mimine/features/settings/setting_mock_constant.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<ContactItem> _contacts = [];

  @override
  void initState() {
    super.initState();
    _contacts = SettingMockConstant.contactItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: BackIconButton(),
        title: Text('연락처', style: AppTextStyles.blackF18W700),
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
            _buildContactStatsSection(),
            const SizedBox(height: 16),
            _buildContactsListSection(),
            const SizedBox(height: 16),
            _buildContactSettingsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactStatsSection() {
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
          Text('연락처 통계', style: AppTextStyles.blackF16W700H12),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildStatItem(
                '총 연락처',
                '${_contacts.length}명',
                Icons.contacts_outlined,
                Colors.blue,
              ),
              _buildDivider(),
              _buildStatItem(
                '인증된 연락처',
                '${_contacts.where((c) => c.isVerified).length}명',
                Icons.verified_outlined,
                Colors.green,
              ),
              _buildDivider(),
              _buildStatItem(
                '최근 추가',
                '3일 전',
                Icons.schedule_outlined,
                Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactsListSection() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('연락처 목록', style: AppTextStyles.blackF16W700H12),
              TextButton(
                onPressed: () => _showComingSoon(),
                child: Text('전체보기', style: AppTextStyles.primaryF16W600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._contacts.map((contact) => _buildContactItem(contact)),
        ],
      ),
    );
  }

  Widget _buildContactSettingsSection() {
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
          Text('연락처 설정', style: AppTextStyles.blackF16W700H12),
          const SizedBox(height: 16),
          _buildActionItem(
            icon: Icons.import_contacts_outlined,
            title: '연락처 가져오기',
            subtitle: '기기 연락처에서 가져오기',
            onTap: () => _showComingSoon(),
          ),
          _buildDivider(),
          _buildActionItem(
            icon: Icons.sync_outlined,
            title: '연락처 동기화',
            subtitle: '클라우드와 연락처 동기화',
            onTap: () => _showComingSoon(),
          ),
          _buildDivider(),
          _buildActionItem(
            icon: Icons.backup_outlined,
            title: '연락처 백업',
            subtitle: '연락처 데이터 백업',
            onTap: () => _showComingSoon(),
          ),
          _buildDivider(),
          _buildActionItem(
            icon: Icons.settings_outlined,
            title: '연락처 권한 설정',
            subtitle: '연락처 접근 권한 관리',
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

  Widget _buildContactItem(ContactItem contact) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary.withAlpha(10),
            child: Text(
              contact.name[0],
              style: AppTextStyles.blackF16W700H12.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(contact.name, style: AppTextStyles.blackF16H145),
                    const SizedBox(width: 8),
                    if (contact.isVerified)
                      Icon(Icons.verified, size: 16, color: Colors.green[600]),
                  ],
                ),
                const SizedBox(height: 4),
                Text(contact.email, style: AppTextStyles.greyF13),
                const SizedBox(height: 2),
                Text(contact.phone, style: AppTextStyles.greyF13),
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) => _handleContactAction(value, contact),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'edit', child: Text('편집')),
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

  void _handleContactAction(String action, ContactItem contact) {
    switch (action) {
      case 'edit':
        _showComingSoon();
        break;
      case 'delete':
        _showDeleteContactDialog(contact);
        break;
    }
  }

  void _showDeleteContactDialog(ContactItem contact) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('연락처 삭제'),
        content: Text('${contact.name}님의 연락처를 삭제하시겠습니까?'),
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
