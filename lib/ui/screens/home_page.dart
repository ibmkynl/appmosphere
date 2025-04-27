import 'package:appmosphere/features/city_search/ui/pages/city_search_page.dart';
import 'package:appmosphere/features/forecast/ui/widget/forecast_list_widget.dart';
import 'package:appmosphere/ui/screens/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

import '../../../../core/location/location_service.dart';
import '../../core/error/app_error.dart';
import '../../features/current_weather/ui/providers/current_weather_provider.dart';
import '../../features/current_weather/ui/widgets/current_weather_widget.dart';
import '../../features/forecast/ui/providers/forecast_weather_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (_) => HomePage());
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _refresh() async {
    try {
      final cityModel = await LocationService.getUserLocation();

      await Provider.of<CurrentWeatherProvider>(context, listen: false).fetchWeatherByCity(cityModel.name, fresh: true);

      await Provider.of<ForecastWeatherProvider>(
        context,
        listen: false,
      ).fetchWeatherByCity(cityModel.lat, cityModel.lon);
    } on AppError catch (error) {
      debugPrint('Failed to fetch location: ${error.message}');
      ErrorNotification.show(context, error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('weather_forecast'.i18n()),
        centerTitle: true,
        leading: IconButton(onPressed: () => Navigator.push(context, CitySearchPage.route()), icon: Icon(Icons.search)),
        actions: [
          IconButton(onPressed: () => Navigator.push(context, SettingsPage.route()), icon: Icon(Icons.settings)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: RefreshIndicator(
          onRefresh: () => _refresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [SizedBox(height: 15.h), CurrentWeatherWidget(), SizedBox(height: 30.h), ForecastListWidget()],
            ),
          ),
        ),
      ),
    );
  }
}
