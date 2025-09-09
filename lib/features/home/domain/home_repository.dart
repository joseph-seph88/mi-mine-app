import 'package:mimine/common/entities/user_entity.dart';
import 'package:mimine/features/home/domain/entites/ad_entity.dart';
import 'package:mimine/features/home/domain/entites/notification_entity.dart';

abstract class HomeRepository {
  Future<UserEntity> getMyInfo();
  Future<List<AdEntity>> getAdInfo();
  Future<List<NotificationEntity>> getNotificationInfo();
  Future<List<Map<String, dynamic>>> updateMarkAllAsRead(List<int?> notificationIdList);
  Future<List<Map<String, dynamic>>> updateMarkRead(int notificationId);
}
