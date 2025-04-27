import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/settings_provider.dart';

class UnitConverter {
  /// Basic Conversions
  static double metersPerSecondToFeetPerSecond(double metersPerSecond) {
    return metersPerSecond * 3.28084;
  }

  static double metersToFeet(double meters) {
    return meters * 3.28084;
  }

  static double celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  static double feetPerSecondToMetersPerSecond(double feetPerSecond) {
    return feetPerSecond / 3.28084;
  }

  static double feetToMeters(double feet) {
    return feet / 3.28084;
  }

  static double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  /// Automatically formats temperature based on user unit system.
  static String formatTemperature(BuildContext context, double tempCelsius) {
    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    if (settingsProvider.unit == UnitEnums.metric) {
      return '${tempCelsius.toStringAsFixed(1)}°C';
    } else {
      return '${celsiusToFahrenheit(tempCelsius).toStringAsFixed(1)}°F';
    }
  }

  /// Automatically formats wind speed based on user unit system.
  static String formatWindSpeed(BuildContext context, double speedMetersPerSec) {
    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    if (settingsProvider.unit == UnitEnums.metric) {
      return '${speedMetersPerSec.toStringAsFixed(1)} m/s';
    } else {
      final speedFeetPerSec = metersPerSecondToFeetPerSecond(speedMetersPerSec);
      return '${speedFeetPerSec.toStringAsFixed(1)} ft/s';
    }
  }

  /// Automatically formats distance based on user unit system.
  static String formatDistance(BuildContext context, double distanceMeters) {
    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    if (settingsProvider.unit == UnitEnums.metric) {
      return '${(distanceMeters / 1000).toStringAsFixed(1)} km';
    } else {
      final distanceFeet = metersToFeet(distanceMeters);
      final distanceMiles = distanceFeet / 5280;
      return '${distanceMiles.toStringAsFixed(1)} mi';
    }
  }
}
