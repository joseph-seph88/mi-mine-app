import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/common/enums/permission_status_type.dart';
import 'package:mimine/features/shell/domain/shell_usecase.dart';
import 'package:mimine/features/shell/presentation/cubits/shell_state.dart';
import 'package:permission_handler/permission_handler.dart';

class ShellCubit extends Cubit<ShellState> {
  final ShellUsecase _shellUsecase;

  ShellCubit(this._shellUsecase) : super(ShellState());

  Future<void> openPermissionAppSettings(Permission permission) async {
    await _shellUsecase.openPermissionAppSettings(permission);
  }

  Future<void> checkRequestPermission() async {
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
      } else if (hasDenied) {
        emit(
          state.copyWith(
            permissionStatusMap: permissionStatusMap,
            permissionStatusType: PermissionStatusType.permissionDenied,
          ),
        );
      } else {
        emit(
          state.copyWith(
            permissionStatusMap: permissionStatusMap,
            permissionStatusType: PermissionStatusType.permissionGranted,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          permissionStatusType: PermissionStatusType.permissionDenied,
          errorMessage: '권한 확인 중 오류가 발생했습니다.',
        ),
      );
    }
  }

  Future<Map<Permission, PermissionStatus>>
  _checkStoredPermissionStatus() async {
    final permissionStatusMap = <Permission, PermissionStatus>{};

    for (var permission in state.requiredPermissionList) {
      final storedStatusString = await _shellUsecase.getPermissionStatus(
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
        final currentStatus = await _shellUsecase.checkPermission(permission);
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

  Future<Map<Permission, PermissionStatus>> _requestDeniedPermissions(
    List<Permission> deniedPermissions,
    Map<Permission, PermissionStatus> permissionStatusMap,
  ) async {
    for (var permission in deniedPermissions) {
      final requestResult = await _shellUsecase.requestPermission(permission);
      permissionStatusMap[permission] = requestResult;
      if (requestResult == PermissionStatus.granted) {
        await _shellUsecase.setPermissionStatus(permission, requestResult);
      }
    }

    return permissionStatusMap;
  }
}
