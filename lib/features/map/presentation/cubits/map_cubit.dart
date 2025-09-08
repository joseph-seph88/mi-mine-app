import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/common/enums/permission_status_type.dart';
import 'package:mimine/features/map/domain/map_usecase.dart';
import 'package:mimine/features/map/presentation/cubits/map_state.dart';
import 'package:permission_handler/permission_handler.dart';

class MapCubit extends Cubit<MapState> {
  final MapUsecase _mapUsecase;

  MapCubit(this._mapUsecase) : super(MapState());

  void setSelectedFilters(List<String> filters) {
    emit(state.copyWith(selectedFilters: filters));
  }

  Future<void> openPermissionAppSettings(Permission permission) async {
    await _mapUsecase.openPermissionAppSettings(permission);
  }

  Future<bool> checkRequestPermission() async {
    try {
      Map<Permission, PermissionStatus> permissionStatusMap =
          await _checkStoredPermissionStatus();

      final deniedPermissions = _getDeniedPermissions(permissionStatusMap);
      if (deniedPermissions.isNotEmpty) {
        permissionStatusMap = await _requestDeniedPermissions(
          deniedPermissions,
          permissionStatusMap,
        );
      }

      final hasDenied = permissionStatusMap.values.any(
        (status) => status == PermissionStatus.denied,
      );
      final hasPermanentlyDenied = permissionStatusMap.values.any(
        (status) => status == PermissionStatus.permanentlyDenied,
      );

      if (hasPermanentlyDenied) {
        emit(
          state.copyWith(
            permissionStatusMap: permissionStatusMap,
            permissionStatusType:
                PermissionStatusType.permissionPermanentlyDenied,
          ),
        );
        return false;
      } else if (hasDenied) {
        emit(
          state.copyWith(
            permissionStatusMap: permissionStatusMap,
            permissionStatusType: PermissionStatusType.permissionDenied,
          ),
        );
        return false;
      } else {
        emit(
          state.copyWith(
            permissionStatusMap: permissionStatusMap,
            permissionStatusType: PermissionStatusType.permissionGranted,
          ),
        );
        return true;
      }
    } catch (e) {
      emit(
        state.copyWith(
          permissionStatusType: PermissionStatusType.permissionDenied,
        ),
      );
      return false;
    }
  }

  Future<Map<Permission, PermissionStatus>>
  _checkStoredPermissionStatus() async {
    final permissionStatusMap = <Permission, PermissionStatus>{};

    for (var permission in state.requiredPermissionList) {
      final storedStatusString = await _mapUsecase.getPermissionStatus(
        permission,
      );

      if (storedStatusString == PermissionStatus.granted.name ||
          storedStatusString == PermissionStatus.limited.name ||
          storedStatusString == PermissionStatus.provisional.name) {
        final storedStatus = PermissionStatus.values.firstWhere(
          (status) => status.name == storedStatusString,
        );
        permissionStatusMap[permission] = storedStatus;
      } else {
        final currentStatus = await _mapUsecase.checkPermission(permission);
        permissionStatusMap[permission] = currentStatus;
      }
    }

    return permissionStatusMap;
  }

  List<Permission> _getDeniedPermissions(
    Map<Permission, PermissionStatus> statusMap,
  ) {
    return statusMap.entries
        .where((entry) => entry.value == PermissionStatus.denied)
        .map((entry) => entry.key)
        .toList();
  }

  List<Permission> _getPermanentlyDeniedPermissions(
    Map<Permission, PermissionStatus> statusMap,
  ) {
    return statusMap.entries
        .where((entry) => entry.value == PermissionStatus.permanentlyDenied)
        .map((entry) => entry.key)
        .toList();
  }

  Future<Map<Permission, PermissionStatus>> _requestDeniedPermissions(
    List<Permission> deniedPermissions,
    Map<Permission, PermissionStatus> permissionStatusMap,
  ) async {
    for (var permission in deniedPermissions) {
      final requestResult = await _mapUsecase.requestPermission(permission);
      permissionStatusMap[permission] = requestResult;
      if (requestResult == PermissionStatus.granted) {
        await _mapUsecase.setPermissionStatus(permission, requestResult);
      }
    }

    return permissionStatusMap;
  }
}
