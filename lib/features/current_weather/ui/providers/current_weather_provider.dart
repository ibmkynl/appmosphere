import 'package:flutter/material.dart';

import '../../../../core/error/app_error.dart';
import '../../domain/entities/current_weather.dart';
import '../../domain/use_case/get_current_weather_usecase.dart';

class CurrentWeatherProvider extends ChangeNotifier {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;

  CurrentWeather? currentWeather;

  bool isLoading = false;
  String? errorMessage;

  CurrentWeatherProvider({required this.getCurrentWeatherUseCase});

  Future<void> fetchWeatherByCity(String cityName, {required bool fresh}) async {
    try {
      isLoading = true;
      notifyListeners();

      currentWeather = await getCurrentWeatherUseCase.callByCity(cityName, fresh);
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
