import 'package:geolocator/geolocator.dart';

// Class to handle geolocation logic
class Geolocation {
  // Checks if location services and permissions are enabled/granted
  Future<bool> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled on the device
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request permission if denied
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    // If permissions are denied forever, return false
    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    // Permissions granted and services enabled
    return true;
  }

  // Gets the current position if permissions and services are available
  Future<Position?> getPositionFromLocation() async {
    if (await determinePosition()) return Geolocator.getCurrentPosition();

    return null;
  }
}
