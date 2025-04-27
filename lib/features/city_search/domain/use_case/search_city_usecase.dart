import '../entitiy/city_model.dart';
import '../repo/city_repository.dart';

class SearchCityUseCase {
  final CityRepository repository;

  SearchCityUseCase(this.repository);

  Future<List<CityModel>> call(String query) {
    return repository.searchCities(query);
  }
}
