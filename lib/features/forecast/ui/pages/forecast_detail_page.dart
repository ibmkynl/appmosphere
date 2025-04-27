import 'package:flutter/material.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../core/utils/unit_converter.dart'; // <-- Add this import!
import '../../../feature_widgets/info_row.dart';
import '../../domain/entities/forecast_weather.dart';

class ForecastDetailPage extends StatelessWidget {
  final List<Forecast3HourData> dayData;

  const ForecastDetailPage({super.key, required this.dayData});

  static Route<dynamic> route(List<Forecast3HourData> dayData) {
    return MaterialPageRoute(builder: (_) => ForecastDetailPage(dayData: dayData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Helpers.formatDate(dayData.first.dateTime, context))),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: dayData.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final forecast = dayData[index];

          return Card.filled(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(Helpers.formatTime(forecast.dateTime), style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  InfoRow(title: 'temp', value: UnitConverter.formatTemperature(context, forecast.temp)),
                  InfoRow(title: 'feels_like', value: UnitConverter.formatTemperature(context, forecast.feelsLike)),
                  InfoRow(title: 'temp_min', value: UnitConverter.formatTemperature(context, forecast.minTemp)),
                  InfoRow(title: 'temp_max', value: UnitConverter.formatTemperature(context, forecast.maxTemp)),
                  InfoRow(title: 'pressure', value: '${forecast.pressure} hPa'),
                  InfoRow(title: 'sea_level', value: '${forecast.seaLevel} hPa'),
                  InfoRow(title: 'ground_level', value: '${forecast.groundLevel} hPa'),
                  InfoRow(title: 'humidity', value: '${forecast.humidity}%'),
                  InfoRow(title: 'description', value: forecast.description),
                  InfoRow(title: 'clouds', value: '${forecast.clouds}%'),
                  InfoRow(title: 'wind_speed', value: UnitConverter.formatWindSpeed(context, forecast.windSpeed)),
                  InfoRow(title: 'wind_deg', value: '${forecast.windDeg}°'),
                  InfoRow(title: 'wind_gust', value: UnitConverter.formatWindSpeed(context, forecast.windGust)),
                  InfoRow(
                    title: 'visibility',
                    value: UnitConverter.formatDistance(context, forecast.visibility.toDouble()),
                  ),
                  InfoRow(title: 'pop', value: '${(forecast.pop * 100).toStringAsFixed(0)}%'),
                  if ((forecast.pop * 100) > 1) InfoRow(title: 'rain_volume', value: '${forecast.rainVolume} mm'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
