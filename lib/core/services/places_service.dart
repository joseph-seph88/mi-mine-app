import 'package:catching_josh/catching_josh.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';

/// 추후 서버 프록시 방식으로 전환
class PlacesService {
  final FlutterGooglePlacesSdk _placesSdk;

  PlacesService(FlutterGooglePlacesSdk placesSdk) : _placesSdk = placesSdk;

  Future<StandardResult> searchPlaces(String input) async {
    return await joshAsync(() async {
      final result = await _placesSdk.findAutocompletePredictions(
        input,
        countries: ['KR'],
      );

      return result.predictions;
    });
  }

  Future<StandardResult> getPlaceDetails(String placeId) async {
    return await joshAsync(() async {
      final result = await _placesSdk.fetchPlace(
        placeId,
        fields: [
          PlaceField.Id,
          PlaceField.Name,
          PlaceField.Address,
          PlaceField.Location,
          PlaceField.Types,
        ],
      );

      return result;
    });
  }

  Future<StandardResult> getLatLng(String placeId) async {
    return await joshAsync(() async {
      final result = await _placesSdk.fetchPlace(
        placeId,
        fields: [PlaceField.Location],
      );

      final place = result.place;
      if (place != null) {
        return {'place': place.toString()};
      }

      return null;
    });
  }

  Future<StandardResult> searchPlacesNearby(
    String input,
    double latitude,
    double longitude,
  ) async {
    return await joshAsync(() async {
      final result = await _placesSdk.findAutocompletePredictions(
        input,
        countries: ['KR'],
        origin: LatLng(lat: latitude, lng: longitude),
      );

      return result.predictions;
    });
  }
}
