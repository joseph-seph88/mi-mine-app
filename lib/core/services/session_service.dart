import 'package:catching_josh/catching_josh.dart';
import 'package:mimine/common/constants/api_path.dart';
import 'package:mimine/core/infrastructure/network/api_client.dart';

class SessionService {
  final ApiClient _apiClient;
  SessionService(this._apiClient);

  Future<StandardResponse> sessionCheck() async {
    return await joshReq(() => _apiClient.post<void>(
          ApiPath.sessionCheck,
          (json) => json,
        ));
  }

  Future<StandardResponse> invalidateSession() async {
    return await joshReq(() => _apiClient.post<void>(
          ApiPath.sessionInvalidate,
          (json) => json,
        ));
  }
}
