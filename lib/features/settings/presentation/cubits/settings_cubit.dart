import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/common/models/user_request.dart';
import 'package:mimine/common/enums/permission_status_type.dart';
import 'package:mimine/features/settings/domain/settings_usecase.dart';
import 'package:mimine/features/settings/presentation/cubits/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsUsecase _settingsUsecase;
  SettingsCubit(this._settingsUsecase) : super(SettingsState());

  Future<void> loadMyProfile() async {
    final response = await _settingsUsecase.loadMyProfile();
    emit(state.copyWith(userInfo: response));
  }

  Future<void> updateMyProfile({
    String? nickname,
    String? profileImage,
    String? motto,
    String? todayThought,
  }) async {
    final userRequest = UserRequest(
      nickname: nickname,
      profileImage: profileImage,
      motto: motto,
      todayThought: todayThought,
    );
    final response = await _settingsUsecase.updateMyProfile(userRequest);
    emit(state.copyWith(userInfo: response));
  }

    Future<void> openPermissionAppSettings(String permissionType) async {
    await _settingsUsecase.openPermissionAppSettings(permissionType);
  }


    Future<bool> checkRequestPermission() async {
    try {
      emit(state.copyWith(permissionStatusType: null));

      final permissionTypes = state.requiredPermissionList;

      Map<String, String> permissionStatusMap = await _settingsUsecase
          .getPermissionStatuses(permissionTypes);

      final deniedPermissions = _getDeniedPermissionTypes(permissionStatusMap);
      if (deniedPermissions.isNotEmpty) {
        permissionStatusMap = await _settingsUsecase.requestPermissions(
          deniedPermissions,
        );
      }

      final hasPermanentlyDenied = permissionStatusMap.values.any(
        (status) => status == 'permanentlyDenied',
      );
      final hasDenied = permissionStatusMap.values.any(
        (status) => status == 'denied',
      );

      if (hasPermanentlyDenied) {
        emit(
          state.copyWith(
            permissionStatusType:
                PermissionStatusType.permissionPermanentlyDenied,
          ),
        );
        return false;
      } else if (hasDenied) {
        emit(
          state.copyWith(
            permissionStatusType: PermissionStatusType.permissionDenied,
          ),
        );
        return false;
      } else {
        emit(
          state.copyWith(
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

  List<String> _getDeniedPermissionTypes(Map<String, String> statusMap) {
    return statusMap.entries
        .where((entry) => entry.value == 'denied')
        .map((entry) => entry.key)
        .toList();
  }

  void updateImageUrl(String imageUrl, bool hasImageChanged) {
    emit(
      state.copyWith(
        pickedImageUrl: imageUrl,
        hasImageChanged: hasImageChanged,
      ),
    );
  }
}
