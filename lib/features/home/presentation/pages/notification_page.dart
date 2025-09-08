import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/styles/app_text_styles.dart';
import 'package:mimine/common/widgets/network_image_widget.dart';
import 'package:mimine/features/home/domain/entites/notification_entity.dart';
import 'package:mimine/features/home/presentation/cubits/notification/notification_cubit.dart';
import 'package:mimine/features/home/presentation/cubits/notification/notification_state.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            final notificationList = state.notificationList;

            return state.notificationList.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: notificationList.length,
                    itemBuilder: (context, index) {
                      final notification = notificationList[index];
                      return _buildNotificationItem(notification, context);
                    },
                  );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: AppColors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        '알림',
        style: AppTextStyles.blackF20W800LS,
      ),
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: () => context.read<NotificationCubit>().markAllAsRead(),
          child: Text(
            '모두 읽음',
            style: AppTextStyles.primaryF16W600,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.grey.withAlpha(25),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.notifications_none_outlined,
              size: 64,
              color: AppColors.grey.withAlpha(128),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '알림이 없습니다',
            style: AppTextStyles.blackF18W700,
          ),
          const SizedBox(height: 8),
          Text(
            '새로운 활동이 있으면 여기에 표시됩니다',
            style: AppTextStyles.greyWA204F13W400H13,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(NotificationEntity notification, BuildContext context) {
    final isRead = notification.isRead ?? false;
    final title = notification.title ?? '';
    final message = notification.message ?? '';
    final time = notification.time ?? '';
    final avatar = notification.avatar ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(4),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () =>
              context.read<NotificationCubit>().markRead(notification.id ?? 0),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.grey.withAlpha(32),
                  backgroundImage:
                      NetworkImageWidget.getNetworkImageProvider(avatar),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: AppTextStyles.blackF16W700H12,
                            ),
                          ),
                          if (!isRead)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message,
                        style: AppTextStyles.greyWA204F13W400H13,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        time,
                        style: AppTextStyles.greyWA178F12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
