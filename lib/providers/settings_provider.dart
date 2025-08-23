import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  void changeTheme(ThemeMode themeMode) {
    themeMode = themeMode;
    notifyListeners();
  }

  bool isDark() => themeMode == ThemeMode.dark;
}
