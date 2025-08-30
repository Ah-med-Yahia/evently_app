import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/providers/events_provider.dart';
import 'package:evently_app/providers/loaction_provider.dart';
import 'package:evently_app/screens/edit_event_screen.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({
    super.key,
  });

  static const routeName = 'event_details';

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  Set<Circle> circles = <Circle>{};
  late EventModel event;
  GoogleMapController? googleMapController;

  void initCircles() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      EventsProvider eventsProvider =
          Provider.of<EventsProvider>(context, listen: false);
      for (var selectedEvent in eventsProvider.allEvents) {
        circles.add(
          Circle(
            circleId: CircleId(selectedEvent.id),
            center: LatLng(selectedEvent.latitude, selectedEvent.longtiude),
            radius: 15,
            fillColor:
                event.id == selectedEvent.id ? AppTheme.red : AppTheme.black,
            strokeWidth: 30,
            strokeColor:event.id == selectedEvent.id ?AppTheme.red.withOpacity(.3) :AppTheme.black.withOpacity(0.3),
          ),
        );
      }
    });
  }

  Future<void> centerMap(LatLng userLocation) async {
    await googleMapController
        ?.animateCamera(CameraUpdate.newLatLng(userLocation));
  }

  @override
  void initState() {
    initCircles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    event = ModalRoute.of(context)!.settings.arguments as EventModel;
    EventsProvider eventsProvider = Provider.of<EventsProvider>(context);
    LoactionProvider loactionProvider = Provider.of<LoactionProvider>(context);
    Size screenSize = MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.event_details),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditEventScreen.routeName, arguments: event);
              },
              icon: SvgPicture.asset(AppAssets.editIcon)),
          IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.transparent,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                );
                await eventsProvider.removeEvent(eventId: event.id);
                if (context.mounted) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }
              },
              icon: SvgPicture.asset(AppAssets.deleteIcon)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    event.category.image,
                    height: screenSize.height * .23,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  )),
              const SizedBox(
                height: 16,
              ),
              Text(
                event.title,
                style: textTheme.headlineSmall!.copyWith(
                    color: AppTheme.primaryColor, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.primaryColor),
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    SvgPicture.asset(AppAssets.timeIconColored),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${event.dateTime.day} ${DateFormat('MMMM').format(event.dateTime)} ${event.dateTime.year}',
                              style: textTheme.titleMedium!
                                  .copyWith(color: AppTheme.primaryColor),
                            ),
                          ],
                        ),
                        Text(DateFormat('hh:mm a').format(event.dateTime),
                            style: textTheme.titleMedium),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.primaryColor),
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    SvgPicture.asset(AppAssets.locationIconColored),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      event.address,
                      style: textTheme.titleMedium!
                          .copyWith(color: AppTheme.primaryColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                height: 361,
                decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.primaryColor),
                    borderRadius: BorderRadius.circular(16)),
                child: loactionProvider.userLocation == null
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.primaryColor,
                        ),
                      )
                    : Stack(
                        children: [
                          GoogleMap(
                            circles: circles,
                            myLocationEnabled: true,
                            myLocationButtonEnabled: false,
                            onMapCreated: (controller) {
                              googleMapController = controller;
                            },
                            initialCameraPosition: CameraPosition(
                              target: LatLng(event.latitude, event.longtiude),
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
                        ],
                      ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                AppLocalizations.of(context)!.description,
                style: textTheme.titleMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                event.description,
                style: textTheme.titleMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
