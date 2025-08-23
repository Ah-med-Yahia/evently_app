import 'package:evently_app/providers/events_provider.dart';
import 'package:evently_app/tabs/home/home_header.dart';
import 'package:evently_app/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    EventsProvider eventsProvider = Provider.of<EventsProvider>(context);
    return Column(
      children: [
        const HomeHeader(),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: eventsProvider.displayedEvents.length,
            itemBuilder: (_, index) {
              return EventItem(
                event: eventsProvider.displayedEvents[index],
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
}
