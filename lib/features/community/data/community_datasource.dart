import 'package:catching_josh/catching_josh.dart';
import 'package:mimine/common/constants/api_path.dart';
import 'package:mimine/common/mock/post_info_mock.dart';
import 'package:mimine/core/infrastructure/network/api_client.dart';

class CommunityDatasource {
  final ApiClient _apiClient;

  CommunityDatasource(this._apiClient);

  Future<StandardResponse> getAllPosts({int page = 1, int size = 10}) async {
    final response = await _apiClient.get(
      ApiPath.allPosts,
      (json) => json,
      queryParameters: {'page': page, 'size': size},
    );

    if (response.isSuccess == true) {
      return response;
    } else {
      return StandardResponse(
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        isSuccess: response.isSuccess,
        data: PostInfoMock.allPostInfoJson,
        dataType: response.dataType,
      );
    }
  }
}
