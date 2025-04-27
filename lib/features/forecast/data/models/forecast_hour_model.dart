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

  factory Forecast3HourData.fromJson(Map<String, dynamic> json) {
    final main = json['main'];
    final weather = (json['weather'] as List).first;
    final wind = json['wind'];
    final clouds = json['clouds'];
    final sys = json['sys'];
    final rain = json['rain'];

    return Forecast3HourData(
      dateTime: json['dt'],
      dateText: json['dt_txt'] ?? '',
      temp: (main['temp'] as num).toDouble(),
      feelsLike: (main['feels_like'] as num).toDouble(),
      minTemp: (main['temp_min'] as num).toDouble(),
      maxTemp: (main['temp_max'] as num).toDouble(),
      pressure: main['pressure'],
      seaLevel: main['sea_level'] ?? 0,
      groundLevel: main['grnd_level'] ?? 0,
      humidity: main['humidity'],
      tempKf: (main['temp_kf'] as num?)?.toDouble() ?? 0.0,
      description: weather['description'],
      weatherMain: weather['main'],
      iconCode: weather['icon'],
      clouds: clouds['all'],
      windSpeed: (wind['speed'] as num).toDouble(),
      windDeg: wind['deg'],
      windGust: (wind['gust'] as num?)?.toDouble() ?? 0.0,
      visibility: json['visibility'],
      pop: (json['pop'] as num).toDouble(),
      rainVolume: (rain?['3h'] as num?)?.toDouble() ?? 0.0,
      pod: sys['pod'],
    );
  }
}
