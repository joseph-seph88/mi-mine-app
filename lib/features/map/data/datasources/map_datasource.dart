import 'package:catching_josh/catching_josh.dart';
import 'package:mimine/common/constants/api_path.dart';
import 'package:mimine/common/mock/place_info_mock.dart';
import 'package:mimine/core/infrastructure/network/api_client.dart';

class MapDatasource {
  final ApiClient _apiClient;

  MapDatasource(this._apiClient);

  Future<StandardResponse> getPlaceInfo(String placeId) async {
    final response = await _apiClient.get(
      ApiPath.placeInfo,
      (json) => json,
      queryParameters: {'placeId': placeId},
    );
    if (response.isSuccess == true) {
      return response;
    } else {
      return StandardResponse(
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        isSuccess: response.isSuccess,
        data: PlaceInfoMock.placeInfoJson,
        dataType: response.dataType,
      );
    }
  }
}