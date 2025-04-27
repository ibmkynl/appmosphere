import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../injection/service_locator.dart'; // <-- still using service locator

class LocalizationProvider extends ChangeNotifier {
  Locale _locale = const Locale('en', 'US');

  static const fallbackLocale = Locale('en', 'US');

  final languages = ['English', 'Türkçe', 'Español'];
  static const locales = [Locale('en', 'US'), Locale('tr', 'TR'), Locale('es', 'ES')];

  static const _languageCodeKey = 'language_code';

  LocalizationProvider() {
    _setInitialLocale();
  }

  Locale get locale => _locale;

  String get languageCode => _locale.languageCode;

  String get languageName => languages[locales.indexOf(locale)];

  Future<void> _setInitialLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguageCode = prefs.getString(_languageCodeKey);

    if (savedLanguageCode != null) {
      final matchIndex = locales.indexWhere((loc) => loc.languageCode == savedLanguageCode);
      if (matchIndex != -1) {
        _locale = locales[matchIndex];
      } else {
        _locale = fallbackLocale;
      }
    } else {
      final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
      final matchIndex = locales.indexWhere((loc) => loc.languageCode == deviceLocale.languageCode);
      _locale = matchIndex != -1 ? locales[matchIndex] : fallbackLocale;
    }

    notifyListeners();
  }

  Future<void> changeLanguage(String langName) async {
    final index = languages.indexOf(langName);
    if (index != -1) {
      _locale = locales[index];
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageCodeKey, _locale.languageCode);

      if (sl.isRegistered<LocalizationProvider>()) {
        sl.unregister<LocalizationProvider>();
      }
      sl.registerSingleton<LocalizationProvider>(this);
    }
  }
}
