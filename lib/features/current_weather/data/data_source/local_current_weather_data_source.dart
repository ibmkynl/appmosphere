import '../../../../core/local_storage/hive_service.dart';
import '../models/current_weather_model.dart';

abstract class LocalCurrentWeatherDataSource {
  Future<void> cacheWeather(CurrentWeatherModel weather);

  Future<CurrentWeatherModel?> getCachedWeather(String city);
}

class LocalCurrentWeatherDataSourceImpl implements LocalCurrentWeatherDataSource {
  final HiveService hiveService;
  static const String boxName = 'currentWeatherBox';

  LocalCurrentWeatherDataSourceImpl({required this.hiveService});

  @override
  Future<void> cacheWeather(CurrentWeatherModel weather) async {
    await hiveService.put(boxName, weather.cityName, weather);
  }

  @override
  Future<CurrentWeatherModel?> getCachedWeather(String cityName) async {
    final weather = await hiveService.get<CurrentWeatherModel>(boxName, cityName);

    if (weather == null || isCacheExpired(DateTime.fromMillisecondsSinceEpoch(weather.dateTime * 1000))) {
      await hiveService.delete(boxName, cityName);
      return null;
    }

    return weather;
  }

  bool isCacheExpired(DateTime other) {
    return DateTime.now().difference(other).inHours >= 3;
  }
}
