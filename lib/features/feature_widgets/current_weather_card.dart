import 'package:appmosphere/core/utils/unit_converter.dart';
import 'package:appmosphere/features/current_weather/domain/entities/current_weather.dart';
import 'package:appmosphere/features/feature_widgets/weather_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/helpers.dart';
import '../current_weather/ui/pages/current_weather_detail_page.dart';

class CurrentWeatherCard extends StatelessWidget {
  final CurrentWeather currentWeather;
  final bool loading;

  const CurrentWeatherCard({super.key, required this.currentWeather, required this.loading});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card.filled(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.push(context, CurrentWeatherDetailPage.route(currentWeather)),
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: 440.w,
              height: 250.h,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child:
                    loading
                        ? const Center(key: ValueKey('loading'), child: CircularProgressIndicator())
                        : Stack(
                          key: const ValueKey('content'),
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(Helpers.formatTime(currentWeather.dateTime)),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                WeatherIconWidget(iconCode: currentWeather.iconCode, height: 100, width: 100),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(currentWeather.description, style: textTheme.titleMedium),
                                    const SizedBox(height: 8),
                                    Text(currentWeather.cityName, style: textTheme.headlineMedium),
                                    const SizedBox(height: 8),
                                    Text(
                                      UnitConverter.formatTemperature(context, currentWeather.temperature),
                                      style: textTheme.displaySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
