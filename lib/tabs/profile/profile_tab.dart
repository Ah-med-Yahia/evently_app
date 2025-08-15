import 'package:evently_app/tabs/profile/profile_header.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  List<Language> languages = [
    Language(code: 'en', name: 'English'),
    Language(code: 'ar', name: 'العربية'),
  ];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProfileHeader(),
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Language',
                    style: textTheme.titleLarge!.copyWith(
                        color: AppTheme.black, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.primaryColor),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: DropdownButton(
                      value: languages.first.code,
                      items: languages
                          .map((language) => DropdownMenuItem(
                                value: language.code,
                                child: Text(
                                  language.name,
                                  style: textTheme.titleLarge!.copyWith(
                                      color: AppTheme.primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {},
                      borderRadius: BorderRadius.circular(16),
                      underline: const SizedBox(),
                      iconEnabledColor: AppTheme.primaryColor,
                      isExpanded: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Dark Theme',
                  style: textTheme.titleLarge!.copyWith(
                      color: AppTheme.black, fontWeight: FontWeight.bold),
                ),
                Switch(
                  value: false,
                  onChanged: (value) {},
                  activeTrackColor: AppTheme.primaryColor,
                ),
              ]),
            ],
          ),
        )
      ],
    );
  }
}

class Language {
  String code;
  String name;

  Language({required this.code, required this.name});
}
