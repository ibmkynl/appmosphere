import 'package:hive/hive.dart';

import '../../../../core/local_storage/hive_service.dart';
import '../../domain/entitiy/city_model.dart';

abstract class CityLocalDataSource {
  Future<List<CityModel>> searchCities(String query);

  Future<void> saveCities(List<CityModel> cities);
}

class CityLocalDataSourceImpl implements CityLocalDataSource {
  final HiveService hiveService;
  static const String boxName = 'cityBox';

  CityLocalDataSourceImpl({required this.hiveService});

  @override
  Future<List<CityModel>> searchCities(String query) async {
    final List<CityModel> matchingCities = [];

    final box = await Hive.openBox<CityModel>(boxName);

    if (box.isEmpty || !box.isOpen) return matchingCities;

    for (var city in box.values.cast<CityModel>()) {
      if (city.name.toLowerCase().contains(query.toLowerCase())) {
        matchingCities.add(city);
      }
    }

    await box.close();
    return matchingCities;
  }

  @override
  Future<void> saveCities(List<CityModel> cities) async {
    for (var city in cities) {
      final key = '${city.name}_${city.country}';
      await hiveService.put(boxName, key, city);
    }
  }
}
