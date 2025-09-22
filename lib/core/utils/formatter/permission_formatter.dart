import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Permission stringToPermission(String permissionString) {
    switch (permissionString) {
      case 'location':
        return Permission.location;
      case 'camera':
        return Permission.camera;
      case 'photos':
        return Permission.photos;
      default:
        throw UnsupportedError('Unknown permission: $permissionString');
    }
  }

  static String permissionToString(Permission permission) {
    switch (permission) {
      case Permission.location:
        return 'location';
      case Permission.camera:
        return 'camera';
      case Permission.photos:
        return 'photos';
      default:
        throw UnsupportedError('Unknown permission: $permission');
    }
  }

  static String permissionStatusToString(PermissionStatus permissionStatus) {
    switch (permissionStatus) {
      case PermissionStatus.granted:
        return 'granted';
      case PermissionStatus.denied:
        return 'denied';
      case PermissionStatus.restricted:
        return 'restricted';
      case PermissionStatus.limited:
        return 'limited';
      case PermissionStatus.permanentlyDenied:
        return 'permanentlyDenied';
      case PermissionStatus.provisional:
        return 'provisional';
    }
  }
}
