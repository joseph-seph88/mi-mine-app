import 'package:catching_josh/catching_josh.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<StandardResult> getCurrentLocation() async {
    try {
      return await joshAsync(() => Geolocator.getCurrentPosition());
    } catch (e) {
      final position = Position(
        latitude: 37.4907,
        longitude: 127.0246,
        timestamp: DateTime.now(),
        accuracy: 10,
        altitude: 0,
        altitudeAccuracy: 0,
        heading: 0,
        headingAccuracy: 0,
        speed: 0,
        speedAccuracy: 0,
      );
      return StandardResult(
        data: position,
        dataType: position.runtimeType.toString(),
        errorMessage: e.toString(),
      );
    }
  }

  Future<StandardResult> checkLocationPermission() async {
    return await joshAsync(
      () => Geolocator.checkPermission(),
      showErrorLog: true,
      showSuccessLog: true,
    );
  }

  Future<StandardResult> isLocationServiceEnabled() async {
    return await joshAsync(
      () => Geolocator.isLocationServiceEnabled(),
      showErrorLog: true,
      showSuccessLog: true,
    );
  }
}