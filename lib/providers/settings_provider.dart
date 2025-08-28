import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode currentThemeMode = ThemeMode.light;
  String languageCode = 'en';

  void changeTheme(ThemeMode themeMode) {
    currentThemeMode = themeMode;
    notifyListeners();
  }

  bool isDark() => currentThemeMode == ThemeMode.dark;

  void changeLanguage(String language) {
    if (language == languageCode) return;
    languageCode = language;
    notifyListeners();
  }
}
