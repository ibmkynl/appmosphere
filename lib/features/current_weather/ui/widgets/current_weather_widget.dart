import 'package:appmosphere/core/error/app_error.dart';
import 'package:appmosphere/features/city_search/domain/entitiy/city_model.dart';
import 'package:appmosphere/features/feature_widgets/current_weather_card.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

import '../../../../core/location/location_service.dart';
import '../../../feature_widgets/error_widget.dart';
import '../providers/current_weather_provider.dart';

class CurrentWeatherWidget extends StatefulWidget {
  final CityModel? city;

  const CurrentWeatherWidget({super.key, this.city});

  @override
  State<CurrentWeatherWidget> createState() => _CurrentWeatherWidgetState();
}

class _CurrentWeatherWidgetState extends State<CurrentWeatherWidget> {
  @override
  void initState() {
    super.initState();
    _fetchCurrentLocationWeather();
  }

  Future<void> _fetchCurrentLocationWeather() async {
    try {
      final cityModel = widget.city ?? await LocationService.getUserLocation();

      await Provider.of<CurrentWeatherProvider>(
        context,
        listen: false,
      ).fetchWeatherByCity(cityModel.name, fresh: false);
    } on AppError catch (error) {
      debugPrint('Failed to fetch location: ${error.message}');
      ErrorNotification.show(context, error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentWeatherProvider>(
      builder: (context, provider, child) {
        final currentWeather = provider.currentWeather;

        if (provider.errorMessage != null) {
          return CustomErrorWidget(message: provider.errorMessage!.i18n());
        }

        if (currentWeather == null) {
          return Center(child: Text('no_weather_data_available'.i18n()));
        }

        return CurrentWeatherCard(currentWeather: currentWeather, loading: provider.isLoading);
      },
    );
  }
}
