import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mimine/core/infrastructure/device/location_service.dart';
import 'package:mimine/core/infrastructure/storage/prefs_service.dart';
import 'package:mimine/core/services/places_service.dart';
import 'package:mimine/features/map/data/datasources/map_datasource.dart';
import 'package:mimine/features/map/domain/entities/place_entity.dart';
import 'package:mimine/features/map/domain/entities/search_entity.dart';
import 'package:mimine/features/map/domain/repositories/map_repository.dart';

class MapRepositoryImpl extends MapRepository {
  final MapDatasource _mapDatasource;
  final PrefsService _prefsService;
  final PlacesService _placesService;
  final LocationService _locationService;

  MapRepositoryImpl(
    this._mapDatasource,
    this._prefsService,
    this._placesService,
    this._locationService,
  );

  @override
  Future<List<PlaceEntity>> getPlaceInfoList(
    Map<String, dynamic> latLng, {
    List<String>? placeType = const [],
  }) async {
    final result = await _mapDatasource.getPlaceInfoList(
      latLng,
      placeType: placeType,
    );
    final responseData = result.data as List<Map<String, dynamic>>;
    return responseData.map((e) => PlaceEntity.fromJson(e)).toList();
  }

  @override
  Future<List<SearchEntity>> searchPlaces(String query) async {
    final result = await _placesService.searchPlaces(query);
    if (result.data == null) {
      return [];
    }
    final resultData = result.data as List<AutocompletePrediction>;
    return resultData.map((e) => SearchEntity.fromJson(e.toJson())).toList();
  }

  @override
  Future<List<SearchEntity>> searchPlacesNearby(
    String query,
    double latitude,
    double longitude,
  ) async {
    final result = await _placesService.searchPlacesNearby(
      query,
      latitude,
      longitude,
    );
    if (result.data == null) {
      return [];
    }
    final resultData = result.data as List<AutocompletePrediction>;
    return resultData.map((e) => SearchEntity.fromJson(e.toJson())).toList();
  }

  @override
  Future<SearchEntity> getPlaceDetails(String placeId) async {
    final result = await _placesService.getPlaceDetails(placeId);
    if (result.data == null) {
      return SearchEntity(
        placeId: placeId,
        primaryText: '',
        secondaryText: '',
        address: '',
        latLng: {},
        distance: '',
      );
    }
    final resultData = result.data as FetchPlaceResponse;
    return SearchEntity.fromJson(resultData.place?.toJson() ?? {});
  }

  @override
  Future<bool> setRecentSearches(List<String> queryList) async {
    final result = await _prefsService.setStringList(
      'recent_searches',
      queryList,
    );
    return result.data as bool;
  }

  @override
  List<String> getRecentSearches() {
    final result = _prefsService.getStringList('recent_searches');
    if (result.data == null) {
      return [];
    }
    return result.data as List<String>;
  }

  @override
  Future<bool> removeAllRecentSearch() async {
    final result = await _prefsService.remove('recent_searches');
    return result.data as bool;
  }

  @override
  Future<bool> removeOneRecentSearch(String searchText) async {
    final getResult = _prefsService.getStringList('recent_searches');
    if (getResult.data == null) return false;
    final searchList = getResult.data as List<String>;
    searchList.remove(searchText);
    final setResult = await _prefsService.setStringList(
      'recent_searches',
      searchList,
    );
    return setResult.data as bool;
  }

  @override
  Future<Map<String, dynamic>> getCurrentLocation() async {
    final result = await _locationService.getCurrentLocation();
    final position = result.data as Position;
    final Map<String, dynamic> latLng = {
      'lat': position.latitude,
      'lng': position.longitude,
    };
    return latLng;
  }
}
