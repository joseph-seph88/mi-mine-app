import 'package:catching_josh/catching_josh.dart';
import 'package:mimine/core/infrastructure/storage/prefs_service.dart';
import 'package:mimine/core/services/permission_service.dart';
import 'package:mimine/features/shell/domain/shell_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class ShellRepositoryImpl implements ShellRepository {
  final PermissionService _permissionService;
  final PrefsService _prefsService;

  ShellRepositoryImpl(this._permissionService, this._prefsService);

  @override
  Future<StandardResult> checkPermission(Permission permission) async {
    return await _permissionService.checkPermission(permission);
  }

  @override
  Future<StandardResult> requestPermission(Permission permission) async {
    return await _permissionService.requestPermission(permission);
  }

  @override
  Future<StandardResult> openPermissionAppSettings(
      Permission permission) async {
    return await _permissionService.openPermissionAppSettings(permission);
  }

  @override
  Future<String> getPermissionStatus(Permission permission) async {
    final result = _prefsService.getString(permission.toString());
    if (result.isSuccess == true) {
      return result.data.toString();
    } else {
      return PermissionStatus.denied.name;
    }
  }

  @override
  Future<bool> setPermissionStatus(
      Permission permission, PermissionStatus permissionStatus) async {
    final result = await _prefsService.setString(
        permission.toString(), permissionStatus.name);

    if (result.isSuccess == true) {
      return true;
    } else {
      return false;
    }
  }
}
