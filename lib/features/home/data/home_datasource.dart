import 'package:catching_josh/catching_josh.dart';
import 'package:mimine/common/constants/api_path.dart';
import 'package:mimine/common/mock/post_info_mock.dart';
import 'package:mimine/core/infrastructure/network/api_client.dart';
import 'package:mimine/core/services/ad_info_service.dart';
import 'package:mimine/core/services/my_info_service.dart';
import 'package:mimine/core/services/notification_info_service.dart';

class HomeDatasource {
  final ApiClient _apiClient;
  final MyInfoService _myInfoService;
  final AdInfoService _adInfoService;
  final NotificationInfoService _notificationInfoService;

  HomeDatasource(
    this._apiClient,
    this._myInfoService,
    this._adInfoService,
    this._notificationInfoService,
  );

  Future<StandardResponse> getMyInfo() async {
    return await _myInfoService.getMyInfo();
  }

  Future<StandardResponse> getAdInfo() async {
    return await _adInfoService.getAdInfo();
  }

  Future<StandardResponse> getNotificationInfo() async {
    return await _notificationInfoService.getNotificationInfo();
  }

  Future<StandardResponse> updateMarkAllAsRead(
    List<String> notificationIdListString,
  ) async {
    return await _notificationInfoService.updateMarkAllAsRead(
      notificationIdListString,
    );
  }

  Future<StandardResponse> updateMarkRead(int notificationId) async {
    return await _notificationInfoService.updateMarkRead(
      notificationId.toString(),
    );
  }


  Future<StandardResponse> getMyPosts(
    String userId, {
    int page = 1,
    int size = 10,
  }) async {
    final response = await _apiClient.get(
      ApiPath.myPosts,
      (json) => json,
      queryParameters: {'userId': userId, 'page': page, 'size': size},
    );

    if (response.isSuccess == true) {
      return response;
    } else {
      return StandardResponse(
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        isSuccess: response.isSuccess,
        data: PostInfoMock.myPostInfoJson,
        dataType: response.dataType,
      );
    }
  }

  Future<StandardResponse> getMyBestPosts(
    String userId, {
    int page = 1,
    int size = 10,
  }) async {
    final response = await _apiClient.get(
      ApiPath.myBestPosts,
      (json) => json,
      queryParameters: {'userId': userId, 'page': page, 'size': size},
    );

    if (response.isSuccess == true) {
      return response;
    } else {
      final mockData = PostInfoMock.myPostInfoJson;
      final data = mockData.where((e) => e['likeCount'] > 10).toList();

      return StandardResponse(
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        isSuccess: response.isSuccess,
        data: data,
        dataType: response.dataType,
      );
    }
  }
}
