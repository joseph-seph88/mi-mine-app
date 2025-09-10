import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/common/enums/permission_status_type.dart';
import 'package:mimine/features/map/domain/usecases/map_permission_usecase.dart';
import 'package:mimine/features/map/domain/usecases/map_usecase.dart';
import 'package:mimine/features/map/presentation/cubits/map_state.dart';

class MapCubit extends Cubit<MapState> {
  final MapUsecase _mapUsecase;
  final MapPermissionUsecase _mapPermissionUsecase;

  MapCubit(this._mapUsecase, this._mapPermissionUsecase)
    : super(const MapState());

  Future<void> getPlaceInfo(String placeId) async {
    final result = await _mapUsecase.getPlaceInfo(placeId);
    emit(state.copyWith(placeInfoList: result));
  }

  Future<void> getCurrentLocation() async {
    final result = await _mapUsecase.getCurrentLocation();
    emit(state.copyWith(currentLatLng: result));
  }

  Future<void> searchPlaces(String input) async {
    final result = await _mapUsecase.searchPlaces(input);
    emit(state.copyWith(placePredictions: result));
  }

  Future<void> clearPlacePredictions() async {
    emit(state.copyWith(placePredictions: []));
  }

  Future<void> searchPlacesNearby(
    String input,
    double latitude,
    double longitude,
  ) async {
    final result = await _mapUsecase.searchPlacesNearby(
      input,
      latitude,
      longitude,
    );
    emit(state.copyWith(placePredictions: result));
  }

  Future<void> getPlaceDetails(String placeId) async {
    final result = await _mapUsecase.getPlaceDetails(placeId);
    emit(state.copyWith(selectedPlaceInfo: result));
  }

  Future<bool> checkRequestPermission() async {
    try {
      emit(state.copyWith(permissionStatusType: null));

      final permissionTypes = state.requiredPermissionList;

      Map<String, String> permissionStatusMap = await _mapPermissionUsecase
          .checkPermissionStatuses(permissionTypes);

      final deniedPermissions = _getDeniedPermissionTypes(permissionStatusMap);
      if (deniedPermissions.isNotEmpty) {
        permissionStatusMap = await _mapPermissionUsecase.requestPermissions(
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

  void setSelectedFilters(List<String> filters) {
    emit(state.copyWith(selectedFilters: filters));
  }

  void resetSelectedFilters() {
    emit(state.copyWith(selectedFilters: []));
  }

  Future<void> openPermissionAppSettings(String permissionType) async {
    await _mapPermissionUsecase.openPermissionAppSettings(permissionType);
  }

  void setIsSearching(bool isSearching) {
    emit(state.copyWith(isSearching: isSearching));
  }

  Future<void> setRecentSearches(String searchText) async {
    final searchList = state.recentSearches;
    searchList.insert(0, searchText);
    if (searchList.length > 10) {
      searchList.removeLast();
    }
    emit(state.copyWith(recentSearches: searchList));
    await _mapUsecase.setRecentSearches(searchList);
  }

  Future<void> removeOneRecentSearch(String searchText) async {
    final searchList = state.recentSearches;
    if (searchList.contains(searchText)) {
      searchList.remove(searchText);
    }
    emit(state.copyWith(recentSearches: searchList));
    await _mapUsecase.removeOneRecentSearch(searchText);
  }

  Future<void> removeAllRecentSearch() async {
    emit(state.copyWith(recentSearches: []));
    await _mapUsecase.removeAllRecentSearch();
  }

  Future<void> getRecentSearches() async {
    final searchList = _mapUsecase.getRecentSearches();
    emit(state.copyWith(recentSearches: searchList));
  }
}
