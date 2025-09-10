import 'package:mimine/core/infrastructure/device/permission_service.dart';
import 'package:mimine/core/utils/formatter/permission_formatter.dart';
import 'package:mimine/features/map/domain/repositories/map_permission_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class MapPermissionRepositoryImpl implements MapPermissionRepository {
  final PermissionService _permissionService;

  MapPermissionRepositoryImpl(this._permissionService);

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
