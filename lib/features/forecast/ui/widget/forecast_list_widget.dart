import 'package:appmosphere/core/error/app_error.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

import '../../../../core/location/location_service.dart';
import '../../../feature_widgets/error_widget.dart';
import '../../../feature_widgets/forecast_day_list.dart';
import '../providers/forecast_weather_provider.dart';

class ForecastListWidget extends StatefulWidget {
  const ForecastListWidget({super.key});

  @override
  State<ForecastListWidget> createState() => _ForecastListWidgetState();
}

class _ForecastListWidgetState extends State<ForecastListWidget> {
  @override
  void initState() {
    super.initState();
    _fetchForecast();
  }

  Future<void> _fetchForecast() async {
    try {
      final locationModel = await LocationService.getUserLocation();
      await Provider.of<ForecastWeatherProvider>(
        context,
        listen: false,
      ).fetchWeatherByCity(locationModel.lat, locationModel.lon);
    } on AppError catch (error) {
      debugPrint('Failed to fetch forecast: ${error.message}');
      ErrorNotification.show(context, error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForecastWeatherProvider>(
      builder: (context, provider, child) {
        final forecastWeather = provider.forecastWeather;

        if (provider.errorMessage != null) {
          return CustomErrorWidget(message: provider.errorMessage!.i18n());
        }

        if (forecastWeather == null) {
          return Center(child: Text('no_forecast_data_available'.i18n()));
        }

        return ForecastDayList(days: forecastWeather.days, loading: provider.isLoading);
      },
    );
  }
}
