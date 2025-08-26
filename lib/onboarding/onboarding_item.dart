import 'package:evently_app/providers/settings_provider.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem(
      {super.key,
      required this.image,
      required this.description,
      required this.title});

  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Column(
      children: [
        Image.asset(
          image,
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * .4,
        ),
        const SizedBox(
          height: 39,
        ),
        Text(title,
            style: textTheme.titleLarge!.copyWith(
                color: settingsProvider.isDark()
                    ? AppTheme.white
                    : AppTheme.primaryColor,
                fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 30,
        ),
        Text(
          description,
          style: textTheme.titleMedium!.copyWith(
              color:
                  settingsProvider.isDark() ? AppTheme.white : AppTheme.black),
        ),
      ],
    );
  }
}
