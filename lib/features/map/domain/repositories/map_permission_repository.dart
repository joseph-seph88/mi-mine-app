abstract class MapPermissionRepository {
  Future<Map<String, String>> checkPermissionStatuses(
    List<String> permissionTypes,
  );
  Future<Map<String, String>> requestPermissions(List<String> permissionTypes);
  Future<bool> openPermissionAppSettings(String permissionType);
}
