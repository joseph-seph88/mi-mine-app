import 'package:catching_josh/catching_josh.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<StandardResult> checkPermission(Permission permission) async {
    return await joshAsync(() => permission.status);
  }

  Future<StandardResult> requestPermission(Permission permission) async {
    return await joshAsync(() => permission.request());
  }

  Future<StandardResult> openPermissionAppSettings(
      Permission permission) async {
    return await joshAsync(() => openAppSettings());
  }
}
