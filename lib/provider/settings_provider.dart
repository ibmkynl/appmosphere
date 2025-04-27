import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/localization/localization_provider.dart';

enum UnitEnums { metric, imperial }

class SettingsProvider extends ChangeNotifier {
  static const String _isDarkModeKey = 'isDarkMode';
  static const String _unitKey = 'unit';

  bool _isDarkMode = false;
  UnitEnums _unit = UnitEnums.metric;

  bool get isDarkMode => _isDarkMode;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  UnitEnums get unit => _unit;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_isDarkModeKey) ?? false;
    _unit = UnitEnums.values.firstWhere((unit) => unit.name == (prefs.getString(_unitKey) ?? "metric"));
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _saveSettings();
  }

  Future<void> changeUnit(UnitEnums unit) async {
    _unit = unit;
    await _saveSettings();
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isDarkModeKey, _isDarkMode);
    await prefs.setString(_unitKey, _unit.name);
    notifyListeners();
  }

  /// Language change should be done by LocalizationProvider now
  void changeLanguage(BuildContext context, String langName) {
    final localizationProvider = Provider.of<LocalizationProvider>(context, listen: false);
    localizationProvider.changeLanguage(langName);
  }
}
