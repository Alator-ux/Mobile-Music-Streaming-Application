import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

class LocaleProvider extends ChangeNotifier {
  static const String _key = 'selected_language';
  Locale _locale = const Locale('ru');

  Locale get locale => _locale;

  LocaleProvider() {
    _initLocale();
  }

  Future<void> _initLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedCode = prefs.getString(_key);

    if (savedCode != null) {
      _locale = Locale(savedCode);
    } else {
      final deviceLocale = PlatformDispatcher.instance.locale.languageCode;
      _locale = deviceLocale == 'ru' ? const Locale('ru') : const Locale('en');
    }
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;

    _locale = locale;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, locale.languageCode);
  }
}
