import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/providers/events_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  const EventItem({
    super.key,
    required this.event,
  });

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    UserProvider userProvider = Provider.of<UserProvider>(context);
    bool isFav = userProvider.checkEventIsFav(eventId: event.id);
    return Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              event.category.image,
              height: screenSize.height * .23,
              width: double.infinity,
              fit: BoxFit.fill,
            )),
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: AppTheme.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Text(
                '${event.dateTime.day}',
                style: textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
              ),
              Text(
                DateFormat('MMM').format(event.dateTime),
                style: textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 8,
          width: screenSize.width - 32,
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: AppTheme.white, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    event.title,
                    style: textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold, color: AppTheme.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                    onTap: () {
                      if (isFav) {
                        userProvider.removeEventFromoFav(eventId: event.id);
                        Provider.of<EventsProvider>(listen: false,context)
                            .filterFavEvents(userProvider.currentUser!.favEventsIds);
                      } else {
                        userProvider.addEventToFav(eventId: event.id);
                      }
                    },
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      size: 24,
                      color: AppTheme.primaryColor,
                    )),
              ],
            ),
          ),
        )
      ],
    );
  }
}
