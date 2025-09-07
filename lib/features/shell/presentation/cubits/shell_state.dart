import 'package:equatable/equatable.dart';
import 'package:mimine/common/enums/permission_status_type.dart';
import 'package:permission_handler/permission_handler.dart';

class ShellState extends Equatable {
  final List<Permission> requiredPermissionList;
  final Map<Permission, PermissionStatus> permissionStatusMap;
  final PermissionStatusType permissionStatusType;
  final bool isSuccess;
  final String? errorMessage;
  final bool shouldOpenSettings;
  final List<Permission>? permanentlyDeniedPermissions;

  const ShellState({
    this.requiredPermissionList = const [
      Permission.location,
      Permission.camera,
      Permission.photos,
    ],
    this.permissionStatusMap = const {},
    this.permissionStatusType = PermissionStatusType.permissionInitial,
    this.isSuccess = false,
    this.errorMessage,
    this.shouldOpenSettings = false,
    this.permanentlyDeniedPermissions,
  });

  ShellState copyWith({
    List<Permission>? requiredPermissionList,
    Map<Permission, PermissionStatus>? permissionStatusMap,
    PermissionStatusType? permissionStatusType,
    bool? isSuccess,
    String? errorMessage,
    bool? shouldOpenSettings,
    List<Permission>? permanentlyDeniedPermissions,
  }) {
    return ShellState(
      requiredPermissionList:
          requiredPermissionList ?? this.requiredPermissionList,
      permissionStatusMap: permissionStatusMap ?? this.permissionStatusMap,
      permissionStatusType: permissionStatusType ?? this.permissionStatusType,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      shouldOpenSettings: shouldOpenSettings ?? this.shouldOpenSettings,
      permanentlyDeniedPermissions:
          permanentlyDeniedPermissions ?? this.permanentlyDeniedPermissions,
    );
  }

  @override
  List<Object?> get props => [
        requiredPermissionList,
        permissionStatusMap,
        permissionStatusType,
        isSuccess,
        errorMessage,
        shouldOpenSettings,
        permanentlyDeniedPermissions,
      ];
}
