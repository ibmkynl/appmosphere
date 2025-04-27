import '../entities/forecast_weather.dart';

abstract class ForecastRepository {
  Future<ForecastWeather> get7DayForecast(double lat, double lon);
}
