import 'package:evently_app/firebase_services.dart';
import 'package:evently_app/models/category_model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/tabs/home/home_header.dart';
import 'package:evently_app/widgets/event_item.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<EventModel> allEvents = [];
  List<EventModel> displayedEvents = [];

  @override
  void initState() {
    getEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeader(
          filter: filterEvents,
        ),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: displayedEvents.length,
            itemBuilder: (_, index) {
              return EventItem(
                event: displayedEvents[index],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> getEvents() async {
    allEvents = await FirebaseServices.getEvents();
    displayedEvents = allEvents;
    setState(() {});
  }

  void filterEvents(CategoryModel? category) {
    if (category == null) {
      displayedEvents = allEvents;
    } else {
      displayedEvents =
          allEvents.where((event) => event.category == category).toList();
      setState(() {});
    }
  }
}
