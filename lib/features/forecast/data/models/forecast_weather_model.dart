import '../../domain/entities/forecast_weather.dart';

class ForecastWeatherModel extends ForecastWeather {
  ForecastWeatherModel({required super.days});

  factory ForecastWeatherModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = json['list'];

    List<Forecast3HourData> all3hForecasts =
        list.map((jsonItem) {
          return Forecast3HourData(
            dateTime: jsonItem['dt'],
            dateText: jsonItem['dt_txt'] ?? '',
            temp: (jsonItem['main']['temp'] as num).toDouble(),
            feelsLike: (jsonItem['main']['feels_like'] as num).toDouble(),
            minTemp: (jsonItem['main']['temp_min'] as num).toDouble(),
            maxTemp: (jsonItem['main']['temp_max'] as num).toDouble(),
            pressure: jsonItem['main']['pressure'],
            seaLevel: jsonItem['main']['sea_level'],
            groundLevel: jsonItem['main']['grnd_level'],
            humidity: jsonItem['main']['humidity'],
            tempKf: (jsonItem['main']['temp_kf'] as num).toDouble(),
            description: jsonItem['weather'][0]['description'],
            weatherMain: jsonItem['weather'][0]['main'],
            iconCode: jsonItem['weather'][0]['icon'],
            clouds: jsonItem['clouds']['all'],
            windSpeed: (jsonItem['wind']['speed'] as num).toDouble(),
            windDeg: jsonItem['wind']['deg'],
            windGust: (jsonItem['wind']['gust'] as num).toDouble(),
            visibility: jsonItem['visibility'],
            pop: (jsonItem['pop'] as num).toDouble(),
            rainVolume: (jsonItem['rain']?['3h'] ?? 0).toDouble(),
            pod: jsonItem['sys']['pod'],
          );
        }).toList();

    // Group forecasts by day (yyyy-MM-dd)
    Map<String, List<Forecast3HourData>> groupedByDay = {};

    for (var item in all3hForecasts) {
      final date = item.dateText.split(' ')[0];
      groupedByDay.putIfAbsent(date, () => []).add(item);
    }

    // Build list of ForecastDay
    List<ForecastDay> forecastDays =
        groupedByDay.entries.map((entry) {
          return ForecastDay(date: DateTime.parse(entry.key), hourlyData: entry.value);
        }).toList();

    return ForecastWeatherModel(days: forecastDays);
  }
}
