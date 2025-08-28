import 'package:evently_app/providers/settings_provider.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ToggleSwitchLanguage extends StatelessWidget {
  const ToggleSwitchLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of(context);
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppTheme.primaryColor),
          borderRadius: BorderRadius.circular(10)),
      child: ToggleSwitch(
        minWidth: 50,
        minHeight: 30,
        activeBgColor: const [AppTheme.primaryColor],
        inactiveBgColor: Colors.transparent,
        initialLabelIndex: settingsProvider.languageCode == 'en' ? 1 : 0,
        totalSwitches: 2,
        customWidgets: [
          Image.asset(AppAssets.egyptIcon),
          Image.asset(AppAssets.usaIcon),
        ],
        onToggle: (index) {
          settingsProvider.changeLanguage(index == 1 ? 'en' : 'ar');
        },
      ),
    );
  }
}
