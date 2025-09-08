import 'package:mimine/features/map/domain/map_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class MapUsecase {
  final MapRepository _mapRepository;

  MapUsecase(this._mapRepository);

  Future<PermissionStatus> checkPermission(Permission permission) async {
    return await _mapRepository
        .checkPermission(permission)
        .then((value) => value.data as PermissionStatus);
  }

  Future<PermissionStatus> requestPermission(Permission permission) async {
    return await _mapRepository
        .requestPermission(permission)
        .then((value) => value.data as PermissionStatus);
  }

  Future<bool> openPermissionAppSettings(Permission permission) async {
    return await _mapRepository
        .openPermissionAppSettings(permission)
        .then((value) => value.data as bool);
  }

  Future<String> getPermissionStatus(Permission permission) async {
    return await _mapRepository.getPermissionStatus(permission);
  }

  Future<bool> setPermissionStatus(Permission permission, PermissionStatus permissionStatus) async {
    return await _mapRepository.setPermissionStatus(permission, permissionStatus);
  }
}
