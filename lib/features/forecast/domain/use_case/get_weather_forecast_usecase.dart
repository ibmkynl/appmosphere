import 'package:appmosphere/features/forecast/domain/entities/forecast_weather.dart';

import '../repo/forecast_repository.dart';

class GetWeatherForecastUseCase {
  final ForecastRepository repository;

  GetWeatherForecastUseCase(this.repository);

  Future<ForecastWeather> get7DayForecast(double lat, double lon) {
    return repository.get7DayForecast(lat, lon);
  }
}
