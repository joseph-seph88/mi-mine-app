import 'package:equatable/equatable.dart';
import 'package:mimine/common/enums/permission_status_type.dart';
import 'package:permission_handler/permission_handler.dart';

class MapState extends Equatable {
  final List<String> selectedFilters;
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final String? errorMessage;
  final PermissionStatusType permissionStatusType;
  final Map<Permission, PermissionStatus> permissionStatusMap;
  final List<Permission> requiredPermissionList;

  const MapState({
    this.selectedFilters = const [],
    this.isLoading = false,
    this.isError = false,
    this.isSuccess = false,
    this.errorMessage,
    this.permissionStatusType = PermissionStatusType.permissionInitial,
    this.permissionStatusMap = const {},
    this.requiredPermissionList = const [Permission.location],
  });

  MapState copyWith({
    List<String>? selectedFilters,
    bool? isLoading,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    PermissionStatusType? permissionStatusType,
    Map<Permission, PermissionStatus>? permissionStatusMap,
    List<Permission>? requiredPermissionList,
  }) {
    return MapState(
      selectedFilters: selectedFilters ?? this.selectedFilters,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      permissionStatusType: permissionStatusType ?? this.permissionStatusType,
      permissionStatusMap: permissionStatusMap ?? this.permissionStatusMap,
      requiredPermissionList:
          requiredPermissionList ?? this.requiredPermissionList,
    );
  }

  @override
  List<Object?> get props => [
    selectedFilters,
    isLoading,
    isError,
    isSuccess,
    errorMessage,
    permissionStatusType,
    permissionStatusMap,
    requiredPermissionList,
  ];
}
