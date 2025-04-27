import 'package:dio/dio.dart';

import '../error/app_error.dart';
import '../utils/constants.dart';

class ApiClient {
  final Dio dio;

  ApiClient({required this.dio}) {
    dio.options
      ..baseUrl = Constants.baseUrl
      ..connectTimeout = const Duration(seconds: 10)
      ..receiveTimeout = const Duration(seconds: 10)
      ..headers = {'Content-Type': 'application/json'};
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (dioError) {
      throw _mapDioErrorToAppError(dioError);
    } catch (e) {
      throw UnexpectedError('api_unexpected_error');
    }
  }

  AppError _mapDioErrorToAppError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout || error.type == DioExceptionType.receiveTimeout) {
      return NetworkError('api_connection_timeout');
    } else if (error.type == DioExceptionType.badResponse) {
      final statusCode = error.response?.statusCode;
      if (statusCode != null) {
        if (statusCode >= 400 && statusCode < 500) {
          return ServerError('api_client_error');
        } else if (statusCode >= 500) {
          return ServerError('api_server_error');
        }
      }
      return ServerError('api_unknown_server_response');
    } else if (error.type == DioExceptionType.unknown) {
      return NetworkError('api_no_internet_connection');
    } else {
      return UnexpectedError('api_something_went_wrong');
    }
  }
}
