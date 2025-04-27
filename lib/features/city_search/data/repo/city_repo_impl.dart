import '../../domain/entitiy/city_model.dart';
import '../../domain/repo/city_repository.dart';
import '../data_source/city_local_data_source.dart';
import '../data_source/city_remote_data_source.dart';

class CityRepositoryImpl implements CityRepository {
  final CityRemoteDataSource remoteDataSource;
  final CityLocalDataSource localDataSource;

  CityRepositoryImpl({required this.remoteDataSource, required this.localDataSource});

  @override
  Future<List<CityModel>> searchCities(String query) async {
    final localResults = await localDataSource.searchCities(query);

    if (localResults.isNotEmpty) {
      return localResults;
    } else {
      final remoteResults = await remoteDataSource.searchCities(query);
      await localDataSource.saveCities(remoteResults);
      return remoteResults;
    }
  }
}
