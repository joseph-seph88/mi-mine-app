import 'package:catching_josh/catching_josh.dart';
import 'package:mimine/common/constants/api_path.dart';
import 'package:mimine/common/mock/notification_info_mock.dart';
import 'package:mimine/core/infrastructure/network/api_client.dart';

class NotificationInfoService {
  final ApiClient _apiClient;
  NotificationInfoService(this._apiClient);

  Future<StandardResponse> getNotificationInfo() async {
    final response = await _apiClient.get(ApiPath.notification, (json) => json);

    if (response.isSuccess == true) {
      return response;
    } else {
      return StandardResponse(
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        isSuccess: response.isSuccess,
        data: NotificationInfoMock.notificationInfoJson,
        dataType: response.dataType,
      );
    }
  }

  Future<StandardResponse> updateMarkAllAsRead(
    List<String> notificationIdList,
  ) async {
    final response = await _apiClient.patch(
      ApiPath.notificationAllRead,
      (json) => json,
      data: {'notificationIdList': notificationIdList},
    );

    if (response.isSuccess == true) {
      return response;
    } else {
      final mockData = List<Map<String, dynamic>>.from(
        NotificationInfoMock.notificationInfoJson,
      );
      for (var notification in mockData) {
        notification['isRead'] = true;
      }

      return StandardResponse(
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        isSuccess: response.isSuccess,
        data: mockData,
        dataType: response.dataType,
      );
    }
  }

  Future<StandardResponse> updateMarkRead(String notificationId) async {
    final response = await _apiClient.patch(
      ApiPath.notificationRead,
      (json) => json,
      data: {'notificationId': notificationId},
    );

    if (response.isSuccess == true) {
      return response;
    } else {
      final mockData = List<Map<String, dynamic>>.from(
        NotificationInfoMock.notificationInfoJson,
      );
      for (var notification in mockData) {
        if (notification['id'] == notificationId) {
          notification['isRead'] = true;
        }
      }

      return StandardResponse(
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        isSuccess: response.isSuccess,
        data: mockData,
        dataType: response.dataType,
      );
    }
  }
}
