import 'package:catching_josh/catching_josh.dart';
import 'package:mimine/common/models/user_request.dart';
import 'package:mimine/core/services/my_info_service.dart';

class SettingsDatasource {
  final MyInfoService _myInfoService;

  SettingsDatasource(this._myInfoService);

  Future<StandardResponse> loadMyProfile() async {
    final response = await _myInfoService.getMyInfo();
    return response;
  }

  Future<StandardResponse> updateMyProfile(UserRequest userRequest) async {
    final response = await _myInfoService.updateMyInfo(userRequest);
    return response;
  }
}
