import 'package:mimine/features/map/domain/repositories/map_permission_repository.dart';

class MapPermissionUsecase {
  final MapPermissionRepository _mapPermissionRepository;

  MapPermissionUsecase(this._mapPermissionRepository);

  Future<Map<String, String>> checkPermissionStatuses(
    List<String> permissionTypes,
  ) async {
    return await _mapPermissionRepository.checkPermissionStatuses(
      permissionTypes,
    );
  }

  Future<Map<String, String>> requestPermissions(
    List<String> permissionTypes,
  ) async {
    return await _mapPermissionRepository.requestPermissions(permissionTypes);
  }

  Future<bool> openPermissionAppSettings(String permissionType) async {
    return await _mapPermissionRepository.openPermissionAppSettings(
      permissionType,
    );
  }
}
