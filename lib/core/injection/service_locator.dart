import 'package:appmosphere/core/local_storage/hive_service.dart';
import 'package:appmosphere/core/network/api_client.dart';
import 'package:appmosphere/features/city_search/data/data_source/city_local_data_source.dart';
import 'package:appmosphere/features/city_search/data/data_source/city_remote_data_source.dart';
import 'package:appmosphere/features/city_search/data/repo/city_repo_impl.dart';
import 'package:appmosphere/features/city_search/domain/repo/city_repository.dart';
import 'package:appmosphere/features/city_search/domain/use_case/search_city_usecase.dart';
import 'package:appmosphere/features/city_search/ui/provider/city_search_provider.dart';
import 'package:appmosphere/features/current_weather/data/data_source/local_current_weather_data_source.dart';
import 'package:appmosphere/features/forecast/data/data_source/forecast_remote_data_source.dart';
import 'package:appmosphere/features/forecast/data/repo/forecast_repo_impl.dart';
import 'package:appmosphere/features/forecast/domain/repo/forecast_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/current_weather/data/data_source/current_weather_remote_data_source.dart';
import '../../features/current_weather/data/repo/weather_repo_impl.dart';
import '../../features/current_weather/domain/repo/weather_repository.dart';
import '../../features/current_weather/domain/use_case/get_current_weather_usecase.dart';
import '../../features/current_weather/ui/providers/current_weather_provider.dart';
import '../../features/forecast/domain/use_case/get_weather_forecast_usecase.dart';
import '../../features/forecast/ui/providers/forecast_weather_provider.dart';
import '../../provider/settings_provider.dart';
import '../localization/localization_provider.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  sl.registerLazySingleton(() => ApiClient(dio: Dio()));
  sl.registerLazySingleton(() => HiveService());
  sl.registerLazySingleton(() => SettingsProvider());

  // Data Sources
  sl.registerLazySingleton<LocalCurrentWeatherDataSource>(() => LocalCurrentWeatherDataSourceImpl(hiveService: sl()));
  sl.registerLazySingleton<CurrentWeatherDataSource>(() => CurrentWeatherRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<ForecastWeatherDataSource>(() => ForecastWeatherRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<CityRemoteDataSource>(() => CityRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CityLocalDataSource>(() => CityLocalDataSourceImpl(hiveService: sl()));

  // Repository
  sl.registerLazySingleton<CurrentWeatherRepository>(
    () => WeatherRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );
  sl.registerLazySingleton<ForecastRepository>(() => ForecastRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<CityRepository>(() => CityRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()));

  // UseCases
  sl.registerLazySingleton(() => GetCurrentWeatherUseCase(sl()));
  sl.registerLazySingleton(() => GetWeatherForecastUseCase(sl()));
  sl.registerLazySingleton(() => SearchCityUseCase(sl()));

  // Providers
  sl.registerFactory(() => CurrentWeatherProvider(getCurrentWeatherUseCase: sl()));
  sl.registerFactory(() => ForecastWeatherProvider(getWeatherForecastUseCase: sl()));
  sl.registerFactory(() => CitySearchProvider(searchCityUseCase: sl()));

  // Localization
  sl.registerLazySingleton<LocalizationProvider>(() => LocalizationProvider());
}
