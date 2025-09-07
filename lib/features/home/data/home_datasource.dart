  import 'package:catching_josh/catching_josh.dart';
import 'package:mimine/common/constants/api_path.dart';
import 'package:mimine/core/infrastructure/network/api_client.dart';

class HomeDatasource {
    final ApiClient _apiClient;

  HomeDatasource(this._apiClient);

  Future<void> createPost(String title, String description, String imageUrl) async {
    await _apiClient.post(
      ApiPath.createPost,
      (json) => json,
      data: {
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
      },
    );
  }

  Future<StandardResponse> getPost(String postId) async {
    final response = await _apiClient.get(
      ApiPath.getPost,
      (json) => json,
      queryParameters: {
        'postId': postId,
      },
    );

    if (response.isSuccess == true) {
      return response;
    } else {
      return StandardResponse(
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        isSuccess: response.isSuccess,
        data: response.data,
        dataType: response.dataType,
      );
    }
  }

  Future<void> updatePost(String postId, String title, String description, String imageUrl) async {
    await _apiClient.put(
      ApiPath.updatePost,
      (json) => json,
      data: {
        'postId': postId,
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
      },
    );
  }

  Future<void> deletePost(String postId) async {
    await _apiClient.delete(
      ApiPath.deletePost,
      (json) => json,
      data: {
        'postId': postId,
      },
    );
  }
}