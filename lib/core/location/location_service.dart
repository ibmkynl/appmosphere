import 'package:appmosphere/features/city_search/domain/entitiy/city_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../error/app_error.dart';

class LocationService {
  static Future<CityModel> getUserLocation() async {
    try {
      final dio = Dio();
      final response = await dio.get(
        'http://ip-api.com/json/',
        options: Options(sendTimeout: const Duration(seconds: 5), receiveTimeout: const Duration(seconds: 5)),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final city = data['city'];
        final country = data['country'];
        final lat = data['lat'];
        final lon = data['lon'];

        if (city != null && city is String && city.isNotEmpty && lat != null && lon != null) {
          return CityModel(lat: (lat as num).toDouble(), lon: (lon as num).toDouble(), name: city, country: country);
        } else {
          throw ServerError('location_city_missing');
        }
      } else {
        throw ServerError('location_http_failed');
      }
    } on DioException catch (dioError) {
      debugPrint('Dio error at getApproxCity: ${dioError.message}');
      throw NetworkError('location_network_error');
    } catch (e) {
      debugPrint('Unexpected error at getApproxCity: $e');
      throw UnexpectedError('location_unexpected_error');
    }
  }
}
