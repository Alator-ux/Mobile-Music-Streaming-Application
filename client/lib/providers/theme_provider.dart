import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _key = 'selected_theme';
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final String? themeName = prefs.getString(_key);

    if (themeName != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (e) => e.toString() == themeName,
        orElse: () => ThemeMode.system,
      );
      notifyListeners();
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    if (_themeMode == mode) return;

    _themeMode = mode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, mode.toString());
  }
}
