import 'package:flutter/material.dart';
import 'package:to_do/themes/theme.dart';
import 'package:to_do/storage_service.dart';

class ThemeManager extends ChangeNotifier {
  static final ThemeManager _instance = ThemeManager._internal();
  factory ThemeManager() => _instance;
  ThemeManager._internal();

  String _currentTheme = 'Default';
  bool _isInitialized = false;

  String get currentTheme => _currentTheme;
  bool get isInitialized => _isInitialized;

  ThemeData get themeData => appThemes[_currentTheme] ?? defaultTheme;

  void setTheme(String themeName) {
    if (appThemes.containsKey(themeName)) {
      _currentTheme = themeName;
      StorageService.saveTheme(themeName);
      notifyListeners();
    }
  }

  Future<void> _loadTheme() async {
    _currentTheme = await StorageService.loadTheme();
    _isInitialized = true;
    notifyListeners();
  }

  // Public method for explicit initialization
  Future<void> initialize() async {
    if (!_isInitialized) {
      await _loadTheme();
    }
  }
}
