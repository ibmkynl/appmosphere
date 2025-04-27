import 'package:appmosphere/features/forecast/domain/entities/forecast_weather.dart';
import 'package:appmosphere/features/forecast/domain/use_case/get_weather_forecast_usecase.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/app_error.dart';

class ForecastWeatherProvider extends ChangeNotifier {
  final GetWeatherForecastUseCase getWeatherForecastUseCase;

  ForecastWeather? forecastWeather;

  bool isLoading = false;
  String? errorMessage;

  ForecastWeatherProvider({required this.getWeatherForecastUseCase});

  Future<void> fetchWeatherByCity(double lat, double lon) async {
    try {
      isLoading = true;
      notifyListeners();

      forecastWeather = await getWeatherForecastUseCase.get7DayForecast(lat, lon);
      errorMessage = null;
    } on AppError catch (error) {
      errorMessage = error.message;
    } catch (e) {
      errorMessage = 'unexpected_error';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
