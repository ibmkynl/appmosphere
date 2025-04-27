import 'package:appmosphere/features/forecast/data/models/forecast_weather_model.dart';

import '../../../../core/local_storage/hive_service.dart';

abstract class LocalForecastDataSource {
  Future<void> cacheForecast(ForecastWeatherModel forecastWeather);

  Future<ForecastWeatherModel> getCacheForecast(String city);
}

class LocalForecastDataSourceImpl implements LocalForecastDataSource {
  final HiveService hiveService;
  static const String boxName = 'forecastWeatherBox';

  LocalForecastDataSourceImpl({required this.hiveService});

  @override
  Future<void> cacheForecast(ForecastWeatherModel forecastWeather) async {}

  @override
  Future<ForecastWeatherModel> getCacheForecast(String city) {
    throw UnimplementedError();
  }
}
