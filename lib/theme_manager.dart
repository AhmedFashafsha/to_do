import 'package:flutter/material.dart';
import 'package:to_do/themes/theme.dart';

class ThemeManager extends ChangeNotifier {
  static final ThemeManager _instance = ThemeManager._internal();
  factory ThemeManager() => _instance;
  ThemeManager._internal();

  String _currentTheme = 'Default';

  String get currentTheme => _currentTheme;

  ThemeData get themeData => appThemes[_currentTheme] ?? defaultTheme;

  void setTheme(String themeName) {
    if (appThemes.containsKey(themeName)) {
      _currentTheme = themeName;
      notifyListeners();
    }
  }
}
