import 'package:catching_josh/catching_josh.dart';
import 'package:mimine/common/constants/api_path.dart';
import 'package:mimine/common/mock/my_info_mock.dart';
import 'package:mimine/common/models/user_request.dart';
import '../infrastructure/network/api_client.dart';

class MyInfoService {
  final ApiClient _apiClient;
  MyInfoService(this._apiClient);

  Future<StandardResponse> getMyInfo() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
        ApiPath.myInfo, (json) => json);

    if (response.isSuccess == true) {
      return response;
    } else {
      return StandardResponse(
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        isSuccess: response.isSuccess,
        data: MyInfoMock.myInfoJson,
        dataType: response.dataType,
      );
    }
  }

  Future<StandardResponse> updateMyInfo(UserRequest userRequest) async {
    return await joshReq(() => _apiClient.patch(
        ApiPath.myInfo, (json) => json,
        data: userRequest));
  }

  Future<StandardResponse> deleteMyInfo() async {
    return await joshReq(
        () => _apiClient.delete<void>(ApiPath.myInfo, (json) => json));
  }
}
