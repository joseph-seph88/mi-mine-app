import 'package:catching_josh/catching_josh.dart';
import 'package:mimine/common/constants/api_path.dart';
import 'package:mimine/common/mock/post_info_mock.dart';
import 'package:mimine/common/mock/comment_info_mock.dart';
import 'package:mimine/core/infrastructure/network/api_client.dart';
import 'package:mimine/core/services/my_info_service.dart';

class CommunityDatasource {
  final ApiClient _apiClient;
  final MyInfoService _myInfoService;

  CommunityDatasource(this._apiClient, this._myInfoService);

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

  Future<StandardResponse> getAllBestPosts({
    int page = 1,
    int size = 10,
  }) async {
    final response = await _apiClient.get(
      ApiPath.allBestPosts,
      (json) => json,
      queryParameters: {'page': page, 'size': size},
    );

    if (response.isSuccess == true) {
      return response;
    } else {
      final mockData = PostInfoMock.allPostInfoJson;
      final data = mockData
          .where((e) => (e['likeCount'] as int? ?? 0) > 200)
          .toList();

      return StandardResponse(
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        isSuccess: response.isSuccess,
        data: data,
        dataType: response.dataType,
      );
    }
  }

  Future<void> likePost(String postId) async {
    await _apiClient.patch(
      ApiPath.likePost,
      (json) => json,
      data: {'postId': postId},
    );
  }

  Future<void> incrementShareCount(String postId) async {
    await _apiClient.patch(
      ApiPath.shareCount,
      (json) => json,
      data: {'postId': postId},
    );
  }

  Future<StandardResponse> getComments(
    String postId, {
    int page = 1,
    int size = 10,
  }) async {
    final response = await _apiClient.get(
      ApiPath.getComments,
      (json) => json,
      queryParameters: {'postId': postId, 'page': page, 'size': size},
    );

    if (response.isSuccess == true) {
      return response;
    } else {
      return StandardResponse(
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        isSuccess: response.isSuccess,
        data: CommentInfoMock.commentInfoJson,
        dataType: response.dataType,
      );
    }
  }

  Future<void> addComment(String postId, String content) async {
    await _apiClient.post(
      ApiPath.addComment,
      (json) => json,
      data: {'postId': postId, 'content': content},
    );
  }

  Future<StandardResponse> getMyInfo() async {
    return await _myInfoService.getMyInfo();
  }

  Future<void> setIsBookMarked(String postId) async {
    await _apiClient.patch(
      ApiPath.setIsBookMarked,
      (json) => json,
      data: {'postId': postId},
    );
  }
}
