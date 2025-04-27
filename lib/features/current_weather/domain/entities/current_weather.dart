class CurrentWeather {
  final double latitude;
  final double longitude;

  final int weatherId;
  final String mainWeather;
  final String description;
  final String iconCode;

  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int? seaLevel;
  final int? groundLevel;

  final int visibility;

  final double windSpeed;
  final int windDegree;

  final int cloudiness;

  final int dateTime;
  final String country;
  final int sunrise;
  final int sunset;
  final int timezone;

  final int cityId;
  final String cityName;

  const CurrentWeather({
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
}
