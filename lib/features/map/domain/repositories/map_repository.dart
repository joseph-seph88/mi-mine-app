import 'package:mimine/features/map/domain/entities/place_entity.dart';
import 'package:mimine/features/map/domain/entities/search_entity.dart';

  
abstract class MapRepository {
  Future<List<PlaceEntity>> getPlaceInfoList(Map<String, dynamic> latLng, {List<String>? placeType = const []});
  Future<List<SearchEntity>> searchPlaces(String query);
  Future<List<SearchEntity>> searchPlacesNearby(String query, double latitude, double longitude);
  Future<SearchEntity> getPlaceDetails(String placeId);
  Future<bool> setRecentSearches(List<String> queryList);
  List<String> getRecentSearches();
  Future<bool> removeAllRecentSearch();
  Future<bool> removeOneRecentSearch(String searchText);
  Future<Map<String, dynamic>> getCurrentLocation();
}
