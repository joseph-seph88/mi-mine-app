import 'package:catching_josh/catching_josh.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<StandardResult> checkPermission(Permission permission) async {
    return await joshAsync(() => permission.status,
        showErrorLog: true,
        showSuccessLog: true,
        logTitle: "[PermissionService]-checkPermission::");
  }

  Future<StandardResult> requestPermission(Permission permission) async {
    return await joshAsync(() => permission.request(),
        showErrorLog: true,
        showSuccessLog: true,
        logTitle: "[PermissionService]-requestPermission::");
  }

  Future<StandardResult> openPermissionAppSettings(
      Permission permission) async {
    return await joshAsync(() => openAppSettings(),
        showErrorLog: true,
        showSuccessLog: true,
        logTitle: "[PermissionService]-openPermissionAppSettings::");
  }
}
