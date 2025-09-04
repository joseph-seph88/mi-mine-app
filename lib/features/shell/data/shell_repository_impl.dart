import 'package:catching_josh/catching_josh.dart';
import 'package:mimine/core/infrastructure/platform/permission_service.dart';
import 'package:mimine/features/shell/domain/shell_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class ShellRepositoryImpl implements ShellRepository {
  final PermissionService _permissionService;

  ShellRepositoryImpl(this._permissionService);

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
}
