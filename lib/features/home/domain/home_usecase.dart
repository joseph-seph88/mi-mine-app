import 'package:mimine/common/entities/post_entity.dart';
import 'package:mimine/common/entities/user_entity.dart';
import 'package:mimine/features/home/domain/entites/ad_entity.dart';
import 'package:mimine/features/home/domain/entites/notification_entity.dart';
import 'package:mimine/features/home/domain/home_repository.dart';

class HomeUsecase {
  final HomeRepository _homeRepository;

  HomeUsecase(this._homeRepository);

  Future<UserEntity> getMyInfo() async {
    return await _homeRepository.getMyInfo();
  }

  Future<List<AdEntity>> getAdInfo() async {
    return await _homeRepository.getAdInfo();
  }

  Future<List<NotificationEntity>> getNotificationInfo() async {
    return await _homeRepository.getNotificationInfo();
  }

  Future<List<Map<String, dynamic>>> markAllAsRead(List<int?> notificationIdList) async {
    return await _homeRepository.updateMarkAllAsRead(notificationIdList);
  }

  Future<List<Map<String, dynamic>>> markRead(int notificationId) async {
    return await _homeRepository.updateMarkRead(notificationId);
  }

  Future<List<PostEntity>> getMyPosts(String userId) async {
    return await _homeRepository.getMyPosts(userId);
  }

  Future<List<PostEntity>> getMyBestPosts(String userId) async {
    return await _homeRepository.getMyBestPosts(userId);
  }
}
