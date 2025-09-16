import 'package:mimine/common/entities/user_entity.dart';
import 'package:mimine/common/models/user_request.dart';

abstract class SettingsRepository {
  Future<UserEntity> loadMyProfile();
  Future<UserEntity> updateMyProfile(UserRequest userRequest);
  Future<Map<String, String>> checkPermissionStatuses(
    List<String> permissionTypes,
  );
  Future<Map<String, String>> requestPermissions(List<String> permissionTypes);
  Future<bool> openPermissionAppSettings(String permissionType);
}