import 'package:appmosphere/features/feature_widgets/weather_icon_widget.dart';
import 'package:appmosphere/features/forecast/domain/entities/forecast_weather.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../core/utils/helpers.dart';
import '../../core/utils/unit_converter.dart';
import '../../features/forecast/ui/pages/forecast_detail_page.dart';

class ForecastDayRow extends StatelessWidget {
  final ForecastDay day;

  const ForecastDayRow({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),

      child: ListTile(
        onTap: () => Navigator.push(context, ForecastDetailPage.route(day.hourlyData)),
        leading: WeatherIconWidget(iconCode: day.hourlyData.first.iconCode, height: 50, width: 50),
        title: Text(
          Helpers.formatDate(day.hourlyData.first.dateTime, context),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(day.hourlyData.first.description),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${'min'.i18n()}: ${UnitConverter.formatTemperature(context, day.hourlyData.first.minTemp)}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              '${'max'.i18n()}: ${UnitConverter.formatTemperature(context, day.hourlyData.first.maxTemp)}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
