import 'package:mimine/core/services/ad_info_service.dart';
import 'package:mimine/core/services/my_info_service.dart';
import 'package:mimine/core/services/notification_info_service.dart';
import 'package:mimine/features/home/data/home_datasource.dart';
import 'package:mimine/features/home/domain/entites/ad_entity.dart';
import 'package:mimine/features/home/domain/entites/home_entity.dart';
import 'package:mimine/features/home/domain/entites/notification_entity.dart';
import 'package:mimine/features/home/domain/entites/post_entity.dart';
import 'package:mimine/features/home/domain/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource _homeDatasource;
  final MyInfoService _myInfoService;
  final AdInfoService _adInfoService;
  final NotificationInfoService _notificationInfoService;

  HomeRepositoryImpl(
      this._myInfoService, this._adInfoService, this._notificationInfoService, this._homeDatasource);

  @override
  Future<HomeEntity> getMyInfo() async {
    final response = await _myInfoService.getMyInfo();
    final responseData = response.data as Map<String, dynamic>;

    return HomeEntity.fromJson(
      responseData,
      response.statusMessage,
      response.isSuccess ?? false,
    );
  }

  @override
  Future<List<AdEntity>> getAdInfo() async {
    final response = await _adInfoService.getAdInfo();
    final responseData = response.data as List<Map<String, dynamic>>;
    return responseData.map((e) => AdEntity.fromJson(e)).toList();
  }

  @override
  Future<List<NotificationEntity>> getNotificationInfo() async {
    final response = await _notificationInfoService.getNotificationInfo();
    final responseData = response.data as List<Map<String, dynamic>>;
    return responseData.map((e) => NotificationEntity.fromJson(e)).toList();
  }

  @override
  Future<void> updateMarkAllAsRead(List<int?> notificationIdList) async {
    final notificationIdListString = notificationIdList.map((e) => e.toString()).toList();
    await _notificationInfoService.updateMarkAllAsRead(notificationIdListString);
  }

  @override
  Future<void> updateMarkRead(int notificationId) async {
    await _notificationInfoService.updateMarkRead(notificationId.toString());
  }

  @override
  Future<void> createPost(String title, String description, String imageUrl) async {
    await _homeDatasource.createPost(title, description, imageUrl);
  }

  @override
  Future<PostEntity> getPost(String postId) async {
    final response = await _homeDatasource.getPost(postId);
    final responseData = response.data as Map<String, dynamic>;
    return PostEntity.fromJson(responseData);
  }

  @override
  Future<void> updatePost(String postId, String title, String description, String imageUrl) async {
    await _homeDatasource.updatePost(postId, title, description, imageUrl);
  }

  @override
  Future<void> deletePost(String postId) async {
    await _homeDatasource.deletePost(postId);
  }
}
