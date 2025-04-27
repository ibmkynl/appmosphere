abstract class ForecastWeather {
  final List<ForecastDay> days;

  ForecastWeather({required this.days});
}

class ForecastDay {
  final DateTime date;
  final List<Forecast3HourData> hourlyData;

  ForecastDay({required this.date, required this.hourlyData});
}

class Forecast3HourData {
  final int dateTime;
  final String dateText;
  final double temp;
  final double feelsLike;
  final double minTemp;
  final double maxTemp;
  final int pressure;
  final int seaLevel;
  final int groundLevel;
  final int humidity;
  final double tempKf;
  final String description;
  final String weatherMain;
  final String iconCode;
  final int clouds;
  final double windSpeed;
  final int windDeg;
  final double windGust;
  final int visibility;
  final double pop;
  final double rainVolume;
  final String pod;

  Forecast3HourData({
    required this.dateTime,
    required this.dateText,
    required this.temp,
    required this.feelsLike,
    required this.minTemp,
    required this.maxTemp,
    required this.pressure,
    required this.seaLevel,
    required this.groundLevel,
    required this.humidity,
    required this.tempKf,
    required this.description,
    required this.weatherMain,
    required this.iconCode,
    required this.clouds,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.visibility,
    required this.pop,
    required this.rainVolume,
    required this.pod,
  });
}
