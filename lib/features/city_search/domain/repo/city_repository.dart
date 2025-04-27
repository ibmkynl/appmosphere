import '../entitiy/city_model.dart';

abstract class CityRepository {
  Future<List<CityModel>> searchCities(String query);
}
