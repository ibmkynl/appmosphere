import 'package:appmosphere/features/forecast/data/models/forecast_weather_model.dart';
import 'package:appmosphere/features/forecast/domain/entities/forecast_weather.dart';
import 'package:appmosphere/features/forecast/domain/repo/forecast_repository.dart';

import '../data_source/forecast_remote_data_source.dart';

class ForecastRepositoryImpl implements ForecastRepository {
  final ForecastWeatherDataSource remoteDataSource;

  ForecastRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ForecastWeather> get7DayForecast(double lat, double lon) async {
    final data = await remoteDataSource.get5DayForecast(lat, lon);
    return ForecastWeatherModel.fromJson(data);
  }
}
