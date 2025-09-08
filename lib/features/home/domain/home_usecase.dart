import 'package:mimine/features/home/domain/entites/ad_entity.dart';
import 'package:mimine/features/home/domain/entites/home_entity.dart';
import 'package:mimine/features/home/domain/entites/notification_entity.dart';
import 'package:mimine/features/home/domain/entites/post_entity.dart';
import 'package:mimine/features/home/domain/home_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeUsecase {
  final HomeRepository _homeRepository;

  HomeUsecase(this._homeRepository);

  Future<HomeEntity> getMyInfo() async {
    return await _homeRepository.getMyInfo();
  }

  Future<List<AdEntity>> getAdInfo() async {
    return await _homeRepository.getAdInfo();
  }

  Future<List<NotificationEntity>> getNotificationInfo() async {
    return await _homeRepository.getNotificationInfo();
  }

  Future<void> markAllAsRead(List<int?> notificationIdList) async {
    await _homeRepository.updateMarkAllAsRead(notificationIdList);
  }

  Future<void> markRead(int notificationId) async {
    await _homeRepository.updateMarkRead(notificationId);
  }

  Future<void> createPost(String title, String description, String imageUrl) async {
    await _homeRepository.createPost(title, description, imageUrl);
  }

  Future<PostEntity> getPost(String postId) async {
    return await _homeRepository.getPost(postId);
  }

  Future<void> updatePost(String postId, String title, String description, String imageUrl) async {
    await _homeRepository.updatePost(postId, title, description, imageUrl);
  }

  Future<void> deletePost(String postId) async {
    await _homeRepository.deletePost(postId);
  }

    Future<PermissionStatus> checkPermission(Permission permission) async {
    return await _homeRepository
        .checkPermission(permission)
        .then((value) => value.data as PermissionStatus);
  }

  Future<PermissionStatus> requestPermission(Permission permission) async {
    return await _homeRepository
        .requestPermission(permission)
        .then((value) => value.data as PermissionStatus);
  }

  Future<bool> openPermissionAppSettings(Permission permission) async {
    return await _homeRepository
        .openPermissionAppSettings(permission)
        .then((value) => value.data as bool);
  }

  Future<String> getPermissionStatus(Permission permission) async {
    return await _homeRepository.getPermissionStatus(permission);
  }

  Future<bool> setPermissionStatus(Permission permission, PermissionStatus permissionStatus) async {
    return await _homeRepository.setPermissionStatus(permission, permissionStatus);
  }
}
