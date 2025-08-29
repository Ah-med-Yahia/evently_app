import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/providers/events_provider.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({
    super.key,
  });

  static const routeName = 'event_details';

  @override
  Widget build(BuildContext context) {
    EventModel event = ModalRoute.of(context)!.settings.arguments as EventModel;
    EventsProvider eventsProvider = Provider.of(context);
    Size screenSize = MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.event_details),
        actions: [
          IconButton(
              onPressed: () {}, icon: SvgPicture.asset(AppAssets.editIcon)),
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
