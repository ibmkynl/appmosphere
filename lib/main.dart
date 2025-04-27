import 'package:appmosphere/core/theme/app_theme.dart';
import 'package:appmosphere/features/city_search/domain/entitiy/city_model.dart';
import 'package:appmosphere/features/city_search/ui/provider/city_search_provider.dart';
import 'package:appmosphere/features/current_weather/data/models/current_weather_model.dart';
import 'package:appmosphere/features/forecast/ui/providers/forecast_weather_provider.dart';
import 'package:appmosphere/provider/settings_provider.dart';
import 'package:appmosphere/ui/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

import 'core/injection/service_locator.dart';
import 'core/localization/localization_provider.dart';
import 'features/current_weather/ui/providers/current_weather_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();

  Hive.registerAdapter(CurrentWeatherModelAdapter());
  Hive.registerAdapter(CityModelAdapter());

  await initDependencies();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    LocalJsonLocalization.delegate.directories = ['assets/i18n'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
        ChangeNotifierProvider(create: (_) => sl<CitySearchProvider>()),
        ChangeNotifierProvider(create: (_) => sl<CurrentWeatherProvider>()),
        ChangeNotifierProvider(create: (_) => sl<ForecastWeatherProvider>()),
        ChangeNotifierProvider(create: (_) => sl<SettingsProvider>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(440, 956),
        minTextAdapt: true,
        builder: (context, widget) {
          final localization = context.watch<LocalizationProvider>();
          final settings = context.watch<SettingsProvider>();

          return MaterialApp(
            title: 'Appmosphere',
            navigatorKey: MyApp.navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settings.themeMode,
            locale: localization.locale,
            supportedLocales: LocalizationProvider.locales,
            localizationsDelegates: [
              LocalJsonLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
