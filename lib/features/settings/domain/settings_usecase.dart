import 'package:mimine/common/entities/user_entity.dart';
import 'package:mimine/common/models/user_request.dart';
import 'package:mimine/features/settings/domain/settings_repository.dart';

class SettingsUsecase {
  final SettingsRepository _settingsRepository;
  SettingsUsecase(this._settingsRepository);

  Future<UserEntity> loadMyProfile() async {
    return await _settingsRepository.loadMyProfile();
  }

  Future<UserEntity> updateMyProfile(UserRequest userRequest) async {
    return await _settingsRepository.updateMyProfile(userRequest);
  }

  Future<Map<String, String>> getPermissionStatuses(
    List<String> permissionTypes,
  ) async {
    return await _settingsRepository.checkPermissionStatuses(permissionTypes);
  }

  Future<Map<String, String>> requestPermissions(
    List<String> permissionTypes,
  ) async {
    return await _settingsRepository.requestPermissions(permissionTypes);
  }

  Future<bool> openPermissionAppSettings(String permissionType) async {
    return await _settingsRepository.openPermissionAppSettings(permissionType);
  }
}
