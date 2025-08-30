import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class MapEventItem extends StatelessWidget {
  const MapEventItem({super.key, required this.event});

  final EventModel event;

  

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.02).copyWith(
          right: screenSize.width * 0.16, bottom: screenSize.height * 0.05),
      padding: EdgeInsets.symmetric(
        vertical: screenSize.height * 0.01,
        horizontal: screenSize.width * 0.01,
      ),
      height: screenSize.height * 0.1,
      constraints: BoxConstraints(maxWidth: screenSize.width * 0.83),
      decoration: BoxDecoration(
        color: AppTheme.white.withOpacity(0.7),
        border: Border.all(width: 2, color: AppTheme.primaryColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              event.category.image,
              width: screenSize.width * .4,
              height: screenSize.height * .15,
              fit: BoxFit.fill,
            ), // Add image path here
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppTheme.primaryColor),
              ),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined),
                  Expanded(
                    child: Text(event.address,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: AppTheme.primaryColor)),
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
