import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  const EventItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              '',
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
                '21',
                style: textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
              ),
              Text(
                'NOV',
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
                    '',
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
                    onTap: () {},
                    child: const Icon(
                      Icons.favorite,
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
