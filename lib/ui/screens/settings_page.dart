import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

import '../../core/localization/localization_provider.dart';
import '../../provider/settings_provider.dart';
import '../widgets/settings_tile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (_) => const SettingsPage());
  }

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late ValueNotifier<String?> _selectedLanguage;
  late ValueNotifier<UnitEnums> _selectedUnit;
  late ValueNotifier<ThemeMode?> _selectedTheme;

  @override
  void initState() {
    super.initState();

    final localizationProvider = Provider.of<LocalizationProvider>(context, listen: false);
    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);

    _selectedLanguage = ValueNotifier(localizationProvider.languageName);
    _selectedUnit = ValueNotifier(settingsProvider.unit);
    _selectedTheme = ValueNotifier(settingsProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  void dispose() {
    _selectedLanguage.dispose();
    _selectedUnit.dispose();
    _selectedTheme.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("settings".i18n())),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Theme Setting
            ValueListenableBuilder(
              valueListenable: _selectedTheme,
              builder:
                  (context, value, child) => SettingTile(
                    title: "theme".i18n(),
                    trailing: value == ThemeMode.dark ? "dark".i18n() : "light".i18n(),
                    onTap: () {
                      final newTheme = value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
                      _selectedTheme.value = newTheme;
                      settingsProvider.toggleTheme();
                    },
                    leading: Icons.phone_android,
                  ),
            ),

            // Language Setting
            ValueListenableBuilder(
              valueListenable: _selectedLanguage,
              builder:
                  (context, value, child) => SettingTile(
                    title: "language".i18n(),
                    trailing: value ?? "",
                    onTap: () async {
                      await showLanguageBottomSheet();
                    },
                    leading: Icons.language,
                  ),
            ),

            // Unit Setting
            ValueListenableBuilder(
              valueListenable: _selectedUnit,
              builder:
                  (context, value, child) => SettingTile(
                    title: "unit".i18n(),
                    trailing: value.name.i18n(),
                    onTap: () {
                      final newUnit = value == UnitEnums.metric ? UnitEnums.imperial : UnitEnums.metric;
                      _selectedUnit.value = newUnit;
                      settingsProvider.changeUnit(newUnit);
                    },
                    leading: Icons.monitor_weight_outlined,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showLanguageBottomSheet() async {
    final languageProvider = Provider.of<LocalizationProvider>(context, listen: false);
    final languages = languageProvider.languages;
    await showModalBottomSheet(
      context: context,
      builder:
          (context) => BottomSheet(
            onClosing: () {},
            builder:
                (context) => SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("select_language".i18n(), style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                        SizedBox(height: 16.h),
                        ...languages
                            .map(
                              (language) => ListTile(
                                leading: const Icon(Icons.language),
                                title: Text(language),
                                onTap: () {
                                  _selectedLanguage.value = language;
                                  Provider.of<LocalizationProvider>(context, listen: false).changeLanguage(language);
                                  Navigator.pop(context);
                                },
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ),
                ),
            enableDrag: true,
            showDragHandle: true,
            elevation: 10,
          ),
    );
  }
}
