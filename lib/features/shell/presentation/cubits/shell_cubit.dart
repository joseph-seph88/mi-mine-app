import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/common/events/app_events.dart';
import 'package:mimine/common/events/event_bus.dart';
import 'package:mimine/features/shell/domain/shell_usecase.dart';
import 'package:mimine/features/shell/presentation/cubits/shell_state.dart';
import 'package:permission_handler/permission_handler.dart';

class ShellCubit extends Cubit<ShellState> {
  final ShellUsecase _shellUsecase;
  StreamSubscription? _appResumedSubscription;

  ShellCubit(this._shellUsecase) : super(ShellState()) {
    _initEventListeners();
  }

  void _initEventListeners() {
    _appResumedSubscription = eventBus.on<AppResumedEvent>().listen((_) {
      onAppResumed();
    });
  }

  Future<void> onAppResumed() async {
    if (!_needsPermissionCheck()) {
      return;
    }
    await checkRequestPermission();
  }

  bool _needsPermissionCheck() {
    if (state.permissionStatusMap.isEmpty) {
      return true;
    }

    return !state.permissionStatusMap.values
        .every((status) => status == PermissionStatus.granted);
  }

  @override
  Future<void> close() {
    _appResumedSubscription?.cancel();
    return super.close();
  }

  Future<void> checkRequestPermission() async {
    final Map<Permission, PermissionStatus> permissionStatusMap = {};

    for (var permission in state.requiredPermissionList) {
      permissionStatusMap[permission] =
          await _shellUsecase.checkPermission(permission);
    }

    emit(state.copyWith(permissionStatusMap: permissionStatusMap));

    for (var entry in permissionStatusMap.entries) {
      final permission = entry.key;
      final permissionStatus = entry.value;

      switch (permissionStatus) {
        case PermissionStatus.denied:
          final requestResult =
              await _shellUsecase.requestPermission(permission);
          permissionStatusMap[permission] = requestResult;

          emit(state.copyWith(permissionStatusMap: permissionStatusMap));

          if (requestResult == PermissionStatus.denied) {
            continue;
          }
          break;

        case PermissionStatus.permanentlyDenied:
          await _shellUsecase.openPermissionAppSettings(permission);
          break;

        case PermissionStatus.granted:
          continue;

        default:
          continue;
      }
    }
    final allGranted = permissionStatusMap.values
        .every((status) => status == PermissionStatus.granted);

    emit(state.copyWith(
      permissionStatusMap: permissionStatusMap,
      isSuccess: allGranted,
      errorMessage: allGranted ? null : '일부 권한이 허용되지 않았습니다.',
    ));
  }
}
