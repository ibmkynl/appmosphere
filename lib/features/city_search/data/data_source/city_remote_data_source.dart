import '../../../../core/network/api_client.dart';
import '../../../../core/utils/constants.dart';
import '../../domain/entitiy/city_model.dart';

abstract class CityRemoteDataSource {
  Future<List<CityModel>> searchCities(String query);
}

class CityRemoteDataSourceImpl implements CityRemoteDataSource {
  final ApiClient client;

  CityRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CityModel>> searchCities(String query) async {
    final response = await client.get(
      '${Constants.geoBaseUrl}direct',
      queryParameters: {'q': query, 'limit': 5, 'appid': Constants.apiKey},
    );

    final List data = response.data;
    return data.map((json) => CityModel.fromJson(json)).toList();
  }
}
