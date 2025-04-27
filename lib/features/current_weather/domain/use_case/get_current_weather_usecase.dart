import '../entities/current_weather.dart';
import '../repo/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final CurrentWeatherRepository repository;

  GetCurrentWeatherUseCase(this.repository);

  Future<CurrentWeather> callByCity(String cityName, [bool fresh = false]) {
    return repository.getCachedCurrentWeatherByCity(cityName, fresh);
  }
}
