import 'package:mimine/features/map/domain/entities/search_entity.dart';
import 'package:mimine/features/map/domain/repositories/map_repository.dart';

class MapUsecase {
  final MapRepository _mapRepository;

  MapUsecase(this._mapRepository);

  Future<List<SearchEntity>> searchPlaces(String input) async {
    return await _mapRepository.searchPlaces(input);
  }

  Future<List<SearchEntity>> searchPlacesNearby(String input, double latitude, double longitude) async {
    return await _mapRepository.searchPlacesNearby(input, latitude, longitude);
  }

  Future<SearchEntity> getPlaceDetails(String placeId) async {
    return await _mapRepository.getPlaceDetails(placeId);
  }

  Future<bool> setRecentSearches(List<String> queryList) async {
    return await _mapRepository.setRecentSearches(queryList);
  }

  List<String> getRecentSearches() {
    return _mapRepository.getRecentSearches();
  }
  
  Future<bool> removeAllRecentSearch() async {
    return await _mapRepository.removeAllRecentSearch();
  }

  Future<bool> removeOneRecentSearch(String searchText) async {
    return await _mapRepository.removeOneRecentSearch(searchText);
  }

  Future<Map<String, dynamic>> getCurrentLocation() async {
    return await _mapRepository.getCurrentLocation();
  }
}
