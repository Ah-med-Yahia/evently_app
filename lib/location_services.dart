import 'package:evently_app/screens/pick_location_screen.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationServices {
  static Future<LatLng?> pickLocation(BuildContext context) async {
    final LatLng? pickedLocation =
        await Navigator.pushNamed(context, PickLocationScreen.routeName)
            as LatLng?;
    return pickedLocation;
  }

  static Future<String> getLocationAddress(LatLng latLng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    Placemark place = placemarks[0];
    return " ${place.locality}, ${place.country}";
  }
}
