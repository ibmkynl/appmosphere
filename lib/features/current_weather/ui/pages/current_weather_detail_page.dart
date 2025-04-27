import 'package:appmosphere/core/utils/helpers.dart';
import 'package:appmosphere/core/utils/unit_converter.dart'; // <-- Import UnitConverter
import 'package:appmosphere/features/feature_widgets/info_row.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../domain/entities/current_weather.dart';

class CurrentWeatherDetailPage extends StatelessWidget {
  final CurrentWeather currentWeatherModel;

  const CurrentWeatherDetailPage({super.key, required this.currentWeatherModel});

  static Route<dynamic> route(CurrentWeather currentWeatherModel) {
    return MaterialPageRoute(builder: (_) => CurrentWeatherDetailPage(currentWeatherModel: currentWeatherModel));
  }

  @override
  Widget build(BuildContext context) {
    final weather = currentWeatherModel;

    return Scaffold(
      appBar: AppBar(
        title: Text('current_weather_detail_title'.i18n()), // Key for title
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            InfoRow(title: 'city', value: weather.cityName),
            InfoRow(title: 'country', value: weather.country),
            InfoRow(title: 'temperature', value: UnitConverter.formatTemperature(context, weather.temperature)),
            InfoRow(title: 'feels_like', value: UnitConverter.formatTemperature(context, weather.feelsLike)),
            InfoRow(title: 'temp_min', value: UnitConverter.formatTemperature(context, weather.tempMin)),
            InfoRow(title: 'temp_max', value: UnitConverter.formatTemperature(context, weather.tempMax)),
            InfoRow(title: 'description', value: weather.description),
            InfoRow(title: 'main_weather', value: weather.mainWeather),
            InfoRow(title: 'humidity', value: '${weather.humidity}%'),
            InfoRow(title: 'pressure', value: '${weather.pressure} hPa'),
            if (weather.seaLevel != null) InfoRow(title: 'sea_level', value: '${weather.seaLevel} hPa'),
            if (weather.groundLevel != null) InfoRow(title: 'ground_level', value: '${weather.groundLevel} hPa'),
            InfoRow(title: 'visibility', value: UnitConverter.formatDistance(context, weather.visibility.toDouble())),
            InfoRow(title: 'wind_speed', value: UnitConverter.formatWindSpeed(context, weather.windSpeed)),
            InfoRow(title: 'wind_degree', value: '${weather.windDegree}°'),
            InfoRow(title: 'cloudiness', value: '${weather.cloudiness}%'),
            InfoRow(title: 'timezone', value: '${weather.timezone ~/ 3600}h'),
            InfoRow(title: 'sunrise', value: Helpers.formatTime(weather.sunrise)),
            InfoRow(title: 'sunset', value: Helpers.formatTime(weather.sunset)),
          ],
        ),
      ),
    );
  }
}
