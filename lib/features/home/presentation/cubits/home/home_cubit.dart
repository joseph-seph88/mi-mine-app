import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/common/enums/permission_status_type.dart';
import 'package:mimine/features/home/domain/home_usecase.dart';
import 'package:mimine/features/home/presentation/cubits/home/home_state.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeUsecase _homeUsecase;

  HomeCubit(this._homeUsecase) : super(HomeState());

  Future<void> loadHomeData() async {
    final response = await _homeUsecase.getMyInfo();

    emit(state.copyWith(homeData: response));
  }

  Future<void> createPost(
    String title,
    String description,
    String imageUrl,
  ) async {
    await _homeUsecase.createPost(title, description, imageUrl);

    final currentAllContents = state.homeData?.allContents ?? [];
    final updatedAllContents = [
      ...currentAllContents,
      {'imageUrl': imageUrl, 'title': title, 'description': description},
    ];

    emit(
      state.copyWith(
        homeData: state.homeData?.copyWith(allContents: updatedAllContents),
      ),
    );
  }

  Future<void> updatePost(
    String postId,
    String title,
    String description,
    String imageUrl,
  ) async {
    await _homeUsecase.updatePost(postId, title, description, imageUrl);

    final updatedAllContents = state.homeData?.allContents
        ?.map(
          (e) => e['id'] == postId
              ? {
                  'imageUrl': imageUrl,
                  'title': title,
                  'description': description,
                }
              : e,
        )
        .toList();

    emit(
      state.copyWith(
        homeData: state.homeData?.copyWith(allContents: updatedAllContents),
      ),
    );
  }

  Future<void> deletePost(String postId) async {
    await _homeUsecase.deletePost(postId);

    final updatedAllContents = state.homeData?.allContents
        ?.where((e) => e['id'] != postId)
        .toList();
    emit(
      state.copyWith(
        homeData: state.homeData?.copyWith(allContents: updatedAllContents),
      ),
    );
  }

  Future<void> openPermissionAppSettings(Permission permission) async {
    await _homeUsecase.openPermissionAppSettings(permission);
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
      final storedStatusString = await _homeUsecase.getPermissionStatus(
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
        final currentStatus = await _homeUsecase.checkPermission(permission);
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
      final requestResult = await _homeUsecase.requestPermission(permission);
      permissionStatusMap[permission] = requestResult;
      if (requestResult == PermissionStatus.granted) {
        await _homeUsecase.setPermissionStatus(permission, requestResult);
      }
    }

    return permissionStatusMap;
  }
}
