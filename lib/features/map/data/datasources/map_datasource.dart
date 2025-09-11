import 'package:catching_josh/catching_josh.dart';
import 'package:mimine/common/constants/api_path.dart';
import 'package:mimine/common/mock/place_info_mock.dart';
import 'package:mimine/core/infrastructure/network/api_client.dart';

class MapDatasource {
  final ApiClient _apiClient;

  MapDatasource(this._apiClient);

  Future<StandardResponse> getPlaceInfoList(
    Map<String, dynamic> latLng, {
    List<String>? placeType = const [],
  }) async {
    final response = await _apiClient.get(
      ApiPath.placeInfoList,
      (json) => json,
      queryParameters: {'latLng': latLng, 'placeType': placeType},
    );
    if (response.isSuccess == true) {
      return response;
    } else {
      final mockData = PlaceInfoMock.placeInfoJson;
      final placeData = placeType == null || placeType.isEmpty
          ? mockData
          : mockData
                .where((element) => placeType.contains(element['placeType']))
                .toList();

      return StandardResponse(
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        isSuccess: response.isSuccess,
        data: placeData,
        dataType: response.dataType,
      );
    }
  }
}
