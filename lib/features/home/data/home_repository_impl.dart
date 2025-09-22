import 'package:mimine/common/entities/post_entity.dart';
import 'package:mimine/common/entities/user_entity.dart';
import 'package:mimine/features/home/data/home_datasource.dart';
import 'package:mimine/features/home/domain/entites/ad_entity.dart';
import 'package:mimine/features/home/domain/entites/notification_entity.dart';
import 'package:mimine/features/home/domain/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource _homeDatasource;

  HomeRepositoryImpl(this._homeDatasource);

  @override
  Future<UserEntity> getMyInfo() async {
    final response = await _homeDatasource.getMyInfo();
    final responseData = response.data as Map<String, dynamic>;

    return UserEntity.fromJson(
      responseData,
      response.statusMessage ?? '',
      response.isSuccess ?? false,
    );
  }

  @override
  Future<List<AdEntity>> getAdInfo() async {
    final response = await _homeDatasource.getAdInfo();
    final responseData = response.data as List<Map<String, dynamic>>;
    return responseData.map((e) => AdEntity.fromJson(e)).toList();
  }

  @override
  Future<List<NotificationEntity>> getNotificationInfo() async {
    final response = await _homeDatasource.getNotificationInfo();
    final responseData = response.data as List<Map<String, dynamic>>;
    return responseData.map((e) => NotificationEntity.fromJson(e)).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> updateMarkAllAsRead(
    List<int?> notificationIdList,
  ) async {
    final notificationIdListString = notificationIdList
        .map((e) => e.toString())
        .toList();
    final response = await _homeDatasource.updateMarkAllAsRead(
      notificationIdListString,
    );
    return response.data as List<Map<String, dynamic>>;
  }

  @override
  Future<List<Map<String, dynamic>>> updateMarkRead(int notificationId) async {
    final response = await _homeDatasource.updateMarkRead(notificationId);
    return response.data as List<Map<String, dynamic>>;
  }

  @override
  Future<List<PostEntity>> getMyPosts(String userId) async {
    final response = await _homeDatasource.getMyPosts(userId);
    final responseData = response.data as List<Map<String, dynamic>>;
    return responseData.map((e) => PostEntity.fromJson(e)).toList();
  }

  @override
  Future<List<PostEntity>> getMyBestPosts(String userId) async {
    final response = await _homeDatasource.getMyBestPosts(userId);
    final responseData = response.data as List<Map<String, dynamic>>;
    return responseData.map((e) => PostEntity.fromJson(e)).toList();
  }
}
