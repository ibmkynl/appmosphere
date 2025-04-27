import 'package:appmosphere/core/network/api_client.dart';

import '../../../../core/injection/service_locator.dart';
import '../../../../core/localization/localization_provider.dart';
import '../../../../core/utils/constants.dart';

abstract class CurrentWeatherDataSource {
  Future<Map<String, dynamic>> getCurrentWeatherByCity(String cityName);
}

class CurrentWeatherRemoteDataSourceImpl implements CurrentWeatherDataSource {
  final ApiClient client;

  CurrentWeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<Map<String, dynamic>> getCurrentWeatherByCity(String cityName) async {
    final langCode = sl<LocalizationProvider>().languageCode;

    final response = await client.get(
      '${Constants.baseUrl}weather',
      queryParameters: {'q': cityName, 'appid': Constants.apiKey, 'units': 'metric', 'lang': langCode},
    );
    return response.data;
  }
}
