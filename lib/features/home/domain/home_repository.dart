import 'package:catching_josh/catching_josh.dart';
import 'package:mimine/features/home/domain/entites/ad_entity.dart';
import 'package:mimine/features/home/domain/entites/home_entity.dart';
import 'package:mimine/features/home/domain/entites/notification_entity.dart';
import 'package:mimine/features/home/domain/entites/post_entity.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class HomeRepository {
  Future<HomeEntity> getMyInfo();
  Future<List<AdEntity>> getAdInfo();
  Future<List<NotificationEntity>> getNotificationInfo();
  Future<void> updateMarkAllAsRead(List<int?> notificationIdList);
  Future<void> updateMarkRead(int notificationId);
  Future<void> createPost(String title, String description, String imageUrl);
  Future<PostEntity> getPost(String postId);
  Future<void> updatePost(
    String postId,
    String title,
    String description,
    String imageUrl,
  );
  Future<void> deletePost(String postId);
  Future<StandardResult> checkPermission(Permission permission);
  Future<StandardResult> requestPermission(Permission permission);
  Future<StandardResult> openPermissionAppSettings(Permission permission);
  Future<String> getPermissionStatus(Permission permission);
  Future<bool> setPermissionStatus(
    Permission permission,
    PermissionStatus permissionStatus,
  );
}
