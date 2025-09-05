import 'package:catching_josh/catching_josh.dart';
import 'package:mimine/common/constants/api_path.dart';
import 'package:mimine/common/models/user_request.dart';
import 'package:mimine/common/models/user_response.dart';
import '../infrastructure/network/api_client.dart';

class MyInfoService {
  final ApiClient _apiClient;
  MyInfoService(this._apiClient);

  Future<StandardResponse> getMyInfo() async {
    return await joshReq(() => _apiClient.get<UserResponse>(
        ApiPath.myInfo, (json) => UserResponse.fromJson(json)));
  }

  Future<StandardResponse> updateMyInfo(UserRequest userRequest) async {
    return await joshReq(() => _apiClient.patch<UserResponse>(
        ApiPath.myInfo, (json) => UserResponse.fromJson(json),
        data: userRequest));
  }

  Future<StandardResponse> deleteMyInfo() async {
    return await joshReq(
        () => _apiClient.delete<void>(ApiPath.myInfo, (json) => json));
  }
}
