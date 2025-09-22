import 'package:equatable/equatable.dart';
import 'package:mimine/common/entities/user_entity.dart';
import 'package:mimine/common/enums/permission_status_type.dart';

class SettingsState extends Equatable {
  final UserEntity? userInfo;
  final String? errorMessage;
  final bool isSuccess;
  final List<String> requiredPermissionList;
  final Map<String, String>? permissionStatusMap;
  final PermissionStatusType? permissionStatusType;
  final String? pickedImageUrl;
  final bool hasImageChanged;

  const SettingsState({
    this.userInfo,
    this.errorMessage,
    this.isSuccess = false,
    this.requiredPermissionList = const [],
    this.permissionStatusMap,
    this.permissionStatusType,
    this.pickedImageUrl,
    this.hasImageChanged = false,
  });

  SettingsState copyWith({
    UserEntity? userInfo,
    String? errorMessage,
    bool? isSuccess,
    List<String>? requiredPermissionList,
    Map<String, String>? permissionStatusMap,
    PermissionStatusType? permissionStatusType,
    String? pickedImageUrl,
    bool? hasImageChanged,
  }) {
    return SettingsState(
      userInfo: userInfo ?? this.userInfo,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      requiredPermissionList:
          requiredPermissionList ?? this.requiredPermissionList,
      permissionStatusMap: permissionStatusMap ?? this.permissionStatusMap,
      permissionStatusType: permissionStatusType ?? this.permissionStatusType,
      pickedImageUrl: pickedImageUrl ?? this.pickedImageUrl,
      hasImageChanged: hasImageChanged ?? this.hasImageChanged,
    );
  }

  @override
  List<Object?> get props => [
    userInfo,
    errorMessage,
    isSuccess,
    requiredPermissionList,
    permissionStatusMap,
    permissionStatusType,
    pickedImageUrl,
    hasImageChanged,
  ];
}
