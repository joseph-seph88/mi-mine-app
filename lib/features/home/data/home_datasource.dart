import 'package:catching_josh/catching_josh.dart';
import 'package:mimine/core/services/ad_info_service.dart';
import 'package:mimine/core/services/my_info_service.dart';
import 'package:mimine/core/services/notification_info_service.dart';

class HomeDatasource {
  final MyInfoService _myInfoService;
  final AdInfoService _adInfoService;
  final NotificationInfoService _notificationInfoService;

  HomeDatasource(
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
}
