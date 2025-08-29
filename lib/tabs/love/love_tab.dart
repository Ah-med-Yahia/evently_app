import 'dart:developer';

import 'package:evently_app/providers/events_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/widgets/custome_text_form_field.dart';
import 'package:evently_app/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoveTab extends StatefulWidget {
  const LoveTab({super.key});

  @override
  State<LoveTab> createState() => _LoveTabState();
}

class _LoveTabState extends State<LoveTab> {
  late EventsProvider eventsProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      List<String> favoriteIds =
          Provider.of<UserProvider>(listen: false, context)
              .currentUser!
              .favEventsIds;
      eventsProvider.filterFavEvents(favoriteIds);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    eventsProvider = Provider.of<EventsProvider>(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            CustomeTextFormField(
              hintText: 'Search for Event',
              prefixIconImage: AppAssets.searchIcon,
              onChanged: (query) {},
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: eventsProvider.favoriteEvents.length,
                itemBuilder: (_, index) {
                  log(eventsProvider.favoriteEvents.length.toString());
                  return EventItem(
                    event: eventsProvider.favoriteEvents[index],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
