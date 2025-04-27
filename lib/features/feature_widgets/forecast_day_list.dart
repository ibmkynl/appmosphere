import 'package:appmosphere/features/forecast/domain/entities/forecast_weather.dart';
import 'package:flutter/material.dart';

import 'forecast_day_row.dart';

class ForecastDayList extends StatelessWidget {
  final List<ForecastDay> days;
  final bool loading;

  const ForecastDayList({super.key, required this.days, required this.loading});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child:
          loading
              ? const CircularProgressIndicator(key: ValueKey('loading'))
              : ListView.builder(
                key: const ValueKey('content'),
                itemCount: days.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final day = days[index];
                  return ForecastDayRow(day: day);
                },
              ),
    );
  }
}
