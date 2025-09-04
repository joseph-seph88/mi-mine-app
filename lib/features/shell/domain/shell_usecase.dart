import 'package:mimine/features/shell/domain/shell_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class ShellUsecase {
  final ShellRepository _shellRepository;

  ShellUsecase(this._shellRepository);

  Future<PermissionStatus> checkPermission(Permission permission) async {
    return await _shellRepository
        .checkPermission(permission)
        .then((value) => value.data as PermissionStatus);
  }

  Future<PermissionStatus> requestPermission(Permission permission) async {
    return await _shellRepository
        .requestPermission(permission)
        .then((value) => value.data as PermissionStatus);
  }

  Future<bool> openPermissionAppSettings(Permission permission) async {
    return await _shellRepository
        .openPermissionAppSettings(permission)
        .then((value) => value.data as bool);
  }
}
