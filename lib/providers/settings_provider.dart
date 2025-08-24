import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  String languageCode = 'ar';

  void changeTheme(ThemeMode themeMode) {
    themeMode = themeMode;
    notifyListeners();
  }

  bool isDark() => themeMode == ThemeMode.dark;

  void changeLanguage(String language) {
    if (language == languageCode) return;
    languageCode = language;
    notifyListeners();
  }
}
