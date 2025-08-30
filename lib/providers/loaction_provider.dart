import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LoactionProvider extends ChangeNotifier {
  LatLng? userLocation;

  Future<void> getCurrentLocation(BuildContext context) async {
    PermissionStatus permissionStatus = await Permission.location.request();

    if (permissionStatus.isGranted) {
      try {
        Position myPosition = await Geolocator.getCurrentPosition();
        userLocation = LatLng(myPosition.latitude, myPosition.longitude);
        notifyListeners();
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to get current location")),
          );
        }
      }
    } else if (permissionStatus.isDenied) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permission denied")),
        );
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
