import 'package:appmosphere/core/network/api_client.dart';

import '../../../../core/injection/service_locator.dart';
import '../../../../core/localization/localization_provider.dart';
import '../../../../core/utils/constants.dart';

abstract class ForecastWeatherDataSource {
  Future<Map<String, dynamic>> get5DayForecast(double lat, double lon);
}

class ForecastWeatherRemoteDataSourceImpl implements ForecastWeatherDataSource {
  final ApiClient client;

  ForecastWeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<Map<String, dynamic>> get5DayForecast(double lat, double lon) async {
    final langCode = sl<LocalizationProvider>().languageCode;

    final response = await client.get(
      '${Constants.baseUrl}forecast',
      queryParameters: {'lat': lat, 'lon': lon, 'appid': Constants.apiKey, 'units': 'metric', 'lang': langCode},
    );

    return response.data;
  }
}
