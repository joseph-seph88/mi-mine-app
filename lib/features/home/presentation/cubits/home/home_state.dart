import 'package:equatable/equatable.dart';
import 'package:mimine/common/enums/permission_status_type.dart';
import 'package:mimine/features/home/domain/entites/home_entity.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeState extends Equatable {
  final HomeEntity? homeData;
  final PermissionStatusType permissionStatusType;
  final Map<Permission, PermissionStatus> permissionStatusMap;
  final List<Permission> requiredPermissionList;

  const HomeState({
    this.homeData,
    this.permissionStatusType = PermissionStatusType.permissionInitial,
    this.permissionStatusMap = const {},
    this.requiredPermissionList = const [
      Permission.camera,
      Permission.photos,
    ],
  });

  HomeState copyWith({
    HomeEntity? homeData,
    PermissionStatusType? permissionStatusType,
    Map<Permission, PermissionStatus>? permissionStatusMap,
    List<Permission>? requiredPermissionList,
  }) {
    return HomeState(
      homeData: homeData ?? this.homeData,
      permissionStatusType: permissionStatusType ?? this.permissionStatusType,
      permissionStatusMap: permissionStatusMap ?? this.permissionStatusMap,
      requiredPermissionList:
          requiredPermissionList ?? this.requiredPermissionList,
    );
  }

  @override
  List<Object?> get props => [
    homeData,
    permissionStatusType,
    permissionStatusMap,
    requiredPermissionList,
  ];
}
