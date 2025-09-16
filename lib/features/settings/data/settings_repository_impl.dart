import 'package:mimine/common/entities/user_entity.dart';
import 'package:mimine/common/models/user_request.dart';
import 'package:mimine/core/infrastructure/device/permission_service.dart';
import 'package:mimine/core/utils/formatter/permission_formatter.dart';
import 'package:mimine/features/settings/data/settings_datasource.dart';
import 'package:mimine/features/settings/domain/settings_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDatasource _settingsDatasource;
  final PermissionService _permissionService;

  SettingsRepositoryImpl(this._settingsDatasource, this._permissionService);

  @override
  Future<UserEntity> loadMyProfile() async {
    final response = await _settingsDatasource.loadMyProfile();
    return UserEntity.fromJson(
      response.data,
      response.statusMessage ?? '',
      response.isSuccess ?? false,
    );
  }

  @override
  Future<UserEntity> updateMyProfile(UserRequest userRequest) async {
    final response = await _settingsDatasource.updateMyProfile(userRequest);
    return UserEntity.fromJson(
      response.data,
      response.statusMessage ?? '',
      response.isSuccess ?? false,
    );
  }

  @override
  Future<Map<String, String>> checkPermissionStatuses(
    List<String> permissionTypes,
  ) async {
    final Map<String, String> statusMap = {};
    for (String permissionType in permissionTypes) {
      final permission = PermissionUtils.stringToPermission(permissionType);
      final result = await _permissionService.checkPermission(permission);
      final permissionStatus = result.data as PermissionStatus;
      statusMap[permissionType] = PermissionUtils.permissionStatusToString(
        permissionStatus,
      );
    }
    return statusMap;
  }

  @override
  Future<Map<String, String>> requestPermissions(
    List<String> permissionTypes,
  ) async {
    final Map<String, String> statusMap = {};
    for (String permissionType in permissionTypes) {
      final permission = PermissionUtils.stringToPermission(permissionType);
      final result = await _permissionService.requestPermission(permission);
      final permissionStatus = result.data as PermissionStatus;
      statusMap[permissionType] = PermissionUtils.permissionStatusToString(
        permissionStatus,
      );
    }
    return statusMap;
  }

  @override
  Future<bool> openPermissionAppSettings(String permissionType) async {
    final permission = PermissionUtils.stringToPermission(permissionType);
    final result = await _permissionService.openPermissionAppSettings(
      permission,
    );
    return result.data as bool;
  }
}
