import 'package:hive/hive.dart';

import '../../domain/entities/current_weather.dart';

part 'current_weather_model.g.dart';

@HiveType(typeId: 0)
class CurrentWeatherModel {
  @HiveField(0)
  final double latitude;

  @HiveField(1)
  final double longitude;

  @HiveField(2)
  final int weatherId;

  @HiveField(3)
  final String mainWeather;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final String iconCode;

  @HiveField(6)
  final double temperature;

  @HiveField(7)
  final double feelsLike;

  @HiveField(8)
  final double tempMin;

  @HiveField(9)
  final double tempMax;

  @HiveField(10)
  final int pressure;

  @HiveField(11)
  final int humidity;

  @HiveField(12)
  final int? seaLevel;

  @HiveField(13)
  final int? groundLevel;

  @HiveField(14)
  final int visibility;

  @HiveField(15)
  final double windSpeed;

  @HiveField(16)
  final int windDegree;

  @HiveField(17)
  final int cloudiness;

  @HiveField(18)
  final int dateTime;

  @HiveField(19)
  final String country;

  @HiveField(20)
  final int sunrise;

  @HiveField(21)
  final int sunset;

  @HiveField(22)
  final int timezone;

  @HiveField(23)
  final int cityId;

  @HiveField(24)
  final String cityName;

  const CurrentWeatherModel({
    required this.latitude,
    required this.longitude,
    required this.weatherId,
    required this.mainWeather,
    required this.description,
    required this.iconCode,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    this.seaLevel,
    this.groundLevel,
    required this.visibility,
    required this.windSpeed,
    required this.windDegree,
    required this.cloudiness,
    required this.dateTime,
    required this.country,
    required this.sunrise,
    required this.sunset,
    required this.timezone,
    required this.cityId,
    required this.cityName,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    final weather = (json['weather'] as List).first;

    return CurrentWeatherModel(
      latitude: (json['coord']['lat'] as num).toDouble(),
      longitude: (json['coord']['lon'] as num).toDouble(),
      weatherId: weather['id'],
      mainWeather: weather['main'],
      description: weather['description'],
      iconCode: weather['icon'],
      temperature: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      tempMin: (json['main']['temp_min'] as num).toDouble(),
      tempMax: (json['main']['temp_max'] as num).toDouble(),
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      seaLevel: json['main']['sea_level'],
      groundLevel: json['main']['grnd_level'],
      visibility: json['visibility'],
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      windDegree: json['wind']['deg'],
      cloudiness: json['clouds']['all'],
      dateTime: json['dt'],
      country: json['sys']['country'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      timezone: json['timezone'],
      cityId: json['id'],
      cityName: json['name'],
    );
  }

  CurrentWeather toEntity() {
    return CurrentWeather(
      latitude: latitude,
      longitude: longitude,
      weatherId: weatherId,
      mainWeather: mainWeather,
      description: description,
      iconCode: iconCode,
      temperature: temperature,
      feelsLike: feelsLike,
      tempMin: tempMin,
      tempMax: tempMax,
      pressure: pressure,
      humidity: humidity,
      seaLevel: seaLevel,
      groundLevel: groundLevel,
      visibility: visibility,
      windSpeed: windSpeed,
      windDegree: windDegree,
      cloudiness: cloudiness,
      dateTime: dateTime,
      country: country,
      sunrise: sunrise,
      sunset: sunset,
      timezone: timezone,
      cityId: cityId,
      cityName: cityName,
    );
  }
}
