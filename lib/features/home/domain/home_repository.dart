import 'package:mimine/features/home/domain/entites/ad_entity.dart';
import 'package:mimine/features/home/domain/entites/home_entity.dart';
import 'package:mimine/features/home/domain/entites/notification_entity.dart';
import 'package:mimine/features/home/domain/entites/post_entity.dart';

abstract class HomeRepository {
  Future<HomeEntity> getMyInfo();
  Future<List<AdEntity>> getAdInfo();
  Future<List<NotificationEntity>> getNotificationInfo();
  Future<void> updateMarkAllAsRead(List<int?> notificationIdList);
  Future<void> updateMarkRead(int notificationId);
  Future<void> createPost(String title, String description, String imageUrl);
  Future<PostEntity> getPost(String postId);
  Future<void> updatePost(String postId, String title, String description, String imageUrl);
  Future<void> deletePost(String postId);
}
