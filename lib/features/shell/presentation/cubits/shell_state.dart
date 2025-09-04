import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

class ShellState extends Equatable {
  final List<Permission> requiredPermissionList;
  final Map<Permission, PermissionStatus> permissionStatusMap;
  final bool isSuccess;
  final String? errorMessage;

  const ShellState({
    this.requiredPermissionList = const [Permission.location],
    this.permissionStatusMap = const {},
    this.isSuccess = false,
    this.errorMessage,
  });

  ShellState copyWith({
    List<Permission>? requiredPermissionList,
    Map<Permission, PermissionStatus>? permissionStatusMap,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return ShellState(
      requiredPermissionList:
          requiredPermissionList ?? this.requiredPermissionList,
      permissionStatusMap: permissionStatusMap ?? this.permissionStatusMap,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        requiredPermissionList,
        permissionStatusMap,
        isSuccess,
        errorMessage,
      ];
}
