import 'package:equatable/equatable.dart';
import 'package:mimine/common/enums/permission_status_type.dart';
import 'package:mimine/features/map/domain/entities/place_entity.dart';
import 'package:mimine/features/map/domain/entities/search_entity.dart';
import 'package:mimine/features/map/domain/enums/map_status_type.dart';

class MapState extends Equatable {
  final List<String> selectedFilters;
  final String? errorMessage;
  final List<String> requiredPermissionList;
  final Map<String, String> permissionStatusMap;
  final PermissionStatusType permissionStatusType;
  final List<String> recentSearches;
  final bool isSearching;
  final List<SearchEntity> placePredictions;
  final SearchEntity? selectedPlaceInfo;
  final Map<String, dynamic> currentLatLng;
  final List<PlaceEntity> placeInfoList;
  final Map<String, dynamic> displayLatLng;
  final MapViewMode mapViewMode;

  const MapState({
    this.selectedFilters = const [],
    this.errorMessage,
    this.permissionStatusType = PermissionStatusType.permissionInitial,
    this.permissionStatusMap = const {},
    this.requiredPermissionList = const ['location'],
    this.recentSearches = const [],
    this.isSearching = false,
    this.placePredictions = const [],
    this.selectedPlaceInfo,
    this.currentLatLng = const {},
    this.placeInfoList = const [],
    this.displayLatLng = const {},
    this.mapViewMode = MapViewMode.idle,
  });

  MapState copyWith({
    List<String>? selectedFilters,
    String? errorMessage,
    PermissionStatusType? permissionStatusType,
    Map<String, String>? permissionStatusMap,
    List<String>? requiredPermissionList,
    List<String>? recentSearches,
    bool? isSearching,
    List<SearchEntity>? placePredictions,
    SearchEntity? selectedPlaceInfo,
    Map<String, dynamic>? currentLatLng,
    List<PlaceEntity>? placeInfoList,
    Map<String, dynamic>? displayLatLng,
    MapViewMode? mapViewMode,
  }) {
    return MapState(
      selectedFilters: selectedFilters ?? this.selectedFilters,
      errorMessage: errorMessage ?? this.errorMessage,
      permissionStatusType: permissionStatusType ?? this.permissionStatusType,
      permissionStatusMap: permissionStatusMap ?? this.permissionStatusMap,
      requiredPermissionList:
          requiredPermissionList ?? this.requiredPermissionList,
      recentSearches: recentSearches ?? this.recentSearches,
      isSearching: isSearching ?? this.isSearching,
      placePredictions: placePredictions ?? this.placePredictions,
      selectedPlaceInfo: selectedPlaceInfo ?? this.selectedPlaceInfo,
      currentLatLng: currentLatLng ?? this.currentLatLng,
      placeInfoList: placeInfoList ?? this.placeInfoList,
      displayLatLng: displayLatLng ?? this.displayLatLng,
      mapViewMode: mapViewMode ?? this.mapViewMode,
    );
  }

  @override
  List<Object?> get props => [
    selectedFilters,
    errorMessage,
    permissionStatusType,
    permissionStatusMap,
    requiredPermissionList,
    recentSearches,
    isSearching,
    placePredictions,
    selectedPlaceInfo,
    currentLatLng,
    placeInfoList,
    displayLatLng,
    mapViewMode,
  ];
}
