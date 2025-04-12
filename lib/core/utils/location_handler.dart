import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationHandler {
  static Future<Position?> getCurrentLocation() async{
    return await Geolocator.getLastKnownPosition();
  }
  static Future<String> getAddressFromLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      Placemark place = placemarks[0];

      return '${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}';

    } catch (e) {
      print(e); // Handle any errors
      return '';
    }
  }
}