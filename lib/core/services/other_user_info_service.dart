import 'package:catching_josh/catching_josh.dart';
import 'package:mimine/common/constants/api_path.dart';
import 'package:mimine/common/mock/other_user_info_mock.dart';
import 'package:mimine/core/infrastructure/network/api_client.dart';

class OtherUserInfoService {
  final ApiClient _apiClient;
  OtherUserInfoService(this._apiClient);

  Future<StandardResponse> getOtherUserInfo(String userId) async {
    final response = await _apiClient.get(
      ApiPath.otherUserInfo,
      (json) => json,
      queryParameters: {'userId': userId},
    );
    if (response.isSuccess == true) {
      return response;
    } else {
      final mockData = OtherUserInfoMock.otherUserInfoJson;
      final data = mockData.where((e) => e['id'] == userId).first;


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
