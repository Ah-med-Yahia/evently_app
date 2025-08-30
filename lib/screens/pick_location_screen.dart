import 'package:evently_app/providers/loaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PickLocationScreen extends StatefulWidget {
  const PickLocationScreen({super.key});

  static const String routeName = 'pick_location';

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Location'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context, selectedLocation);
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: GoogleMap(
        onTap: (latlang) {
          selectedLocation = latlang;
          setState(() {});
        },
        initialCameraPosition: CameraPosition(
          target: Provider.of<LoactionProvider>(context, listen: false)
              .userLocation!,
          zoom: 14,
        ),
        markers: selectedLocation != null
            ? {
                Marker(
                  markerId: const MarkerId("Selected Location"),
                  position: selectedLocation!,
                ),
              }
            : {},
      ),
    );
  }
}
