import 'package:hive/hive.dart';

part 'city_model.g.dart';

@HiveType(typeId: 1)
class CityModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String country;

  @HiveField(2)
  final double lat;

  @HiveField(3)
  final double lon;

  CityModel({required this.name, required this.country, required this.lat, required this.lon});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      name: json['name'],
      country: json['country'],
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
    );
  }
}
