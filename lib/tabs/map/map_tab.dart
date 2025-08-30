import 'package:evently_app/providers/events_provider.dart';
import 'package:evently_app/providers/loaction_provider.dart';
import 'package:evently_app/tabs/map/map_event_item.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  GoogleMapController? googleMapController;

  Future<void> centerMap(LatLng userLocation) async {
    await googleMapController
        ?.animateCamera(CameraUpdate.newLatLng(userLocation));
  }

  void initCircles() {
    EventsProvider eventsProvider =
        Provider.of<EventsProvider>(context, listen: false);
    for (var event in eventsProvider.allEvents) {
      circles.add(
        Circle(
          circleId: CircleId(event.id),
          center: LatLng(event.latitude, event.longtiude),
          radius: 15,
          fillColor: AppTheme.black,
          strokeWidth: 30,
          strokeColor: AppTheme.black.withOpacity(0.3),
        ),
      );
    }
  }

  @override
  void initState() {
    initCircles();
    super.initState();
  }

  Set<Circle> circles = <Circle>{};

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    EventsProvider eventsProvider = Provider.of<EventsProvider>(context);
    LoactionProvider loactionProvider = Provider.of<LoactionProvider>(context);

    return eventsProvider.allEvents.isEmpty
        ? Center(
            child: Text(
              "There is No Events Added 😴",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: AppTheme.primaryColor),
            ),
          )
        : Stack(
            children: [
              loactionProvider.userLocation == null
                  ? const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                        color: AppTheme.primaryColor,
                      ),
                    )
                  : GoogleMap(
                      circles: circles,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      onMapCreated: (controller) {
                        googleMapController = controller;
                      },
                      initialCameraPosition: CameraPosition(
                        target: loactionProvider.userLocation!,
                        zoom: 15,
                      ),
                    ),
              Positioned(
                top: 30,
                right: 10,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15),
                  ),
                  onPressed: () async {
                    await centerMap(loactionProvider.userLocation!);
                  },
                  child: const Icon(
                    Icons.my_location,
                    size: 20,
                    color: AppTheme.white,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: SizedBox(
                  height: screenSize.height * 0.25,
                  width: screenSize.width * 0.83,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * .01,
                        horizontal: screenSize.width * .02),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        var event = eventsProvider.allEvents[index];
                        centerMap(
                            LatLng(event.latitude, event.longtiude));
                        setState(() {
                          
                        });
                      },
                      child: MapEventItem(
                        event: eventsProvider.allEvents[index],
                      ),
                    ),
                    itemCount: eventsProvider.allEvents.length,
                  ),
                ),
              )
            ],
          );
  }
}
