import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Dio createDio() {
  final dio = Dio(BaseOptions(
    baseUrl: dotenv.env['API_BASE_URL'] ?? 'https://tripee-interview.azurewebsites.net/v1',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  // opcional: interceptors, logs
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  return dio;
}