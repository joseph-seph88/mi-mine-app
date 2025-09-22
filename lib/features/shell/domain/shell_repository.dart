import 'package:catching_josh/catching_josh.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class ShellRepository {
  Future<StandardResult> checkPermission(Permission permission);
  Future<StandardResult> requestPermission(Permission permission);
  Future<StandardResult> openPermissionAppSettings(Permission permission);
  Future<String> getPermissionStatus(Permission permission);
  Future<bool> setPermissionStatus(Permission permission, PermissionStatus permissionStatus);
}
