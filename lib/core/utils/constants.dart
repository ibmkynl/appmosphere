import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static final String apiKey = dotenv.env['OPEN_WEATHER_MAP_API_KEY'] ?? '';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/';
  static const String geoBaseUrl = 'http://api.openweathermap.org/geo/1.0/';
}
