import '../../domain/entities/current_weather.dart';
import '../../domain/repo/weather_repository.dart';
import '../data_source/current_weather_remote_data_source.dart';
import '../data_source/local_current_weather_data_source.dart';
import '../models/current_weather_model.dart';

class WeatherRepositoryImpl implements CurrentWeatherRepository {
  final CurrentWeatherDataSource remoteDataSource;
  final LocalCurrentWeatherDataSource localDataSource;

  WeatherRepositoryImpl({required this.remoteDataSource, required this.localDataSource});

  @override
  Future<CurrentWeather> getCachedCurrentWeatherByCity(String cityName, bool fresh) async {
    final cachedWeather = await localDataSource.getCachedWeather(cityName);

    if (cachedWeather != null && !fresh) {
      return cachedWeather.toEntity();
    }

    final data = await remoteDataSource.getCurrentWeatherByCity(cityName);
    final model = CurrentWeatherModel.fromJson(data);

    await localDataSource.cacheWeather(model);

    return CurrentWeatherModel.fromJson(data).toEntity();
  }
}
