import 'package:catching_josh/catching_josh.dart';
import 'package:mimine/common/constants/api_path.dart';
import 'package:mimine/common/mock/ad_info_mock.dart';
import '../infrastructure/network/api_client.dart';

class AdInfoService {
  final ApiClient _apiClient;
  AdInfoService(this._apiClient);

  Future<StandardResponse> getAdInfo() async {
    final response = await _apiClient.get(ApiPath.adInfo, (json) => json);

    if (response.isSuccess == true) {
      return response;
    } else {
      return StandardResponse(
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        isSuccess: response.isSuccess,
        data: AdInfoMock.adInfoJson,
        dataType: response.dataType,
      );
    }
  }
}
