import '../entities/current_weather.dart';

abstract class CurrentWeatherRepository {
  Future<CurrentWeather> getCachedCurrentWeatherByCity(String cityName, bool fresh);
}
