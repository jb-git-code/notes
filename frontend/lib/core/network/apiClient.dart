import 'package:dio/dio.dart';

import '../constants/apiConstants.dart';

class ApiClient {
  ApiClient._() {
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  static final ApiClient instance = ApiClient._();

  late final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),

      headers: {"Content-Type": "application/json"},
    ),
  );
}
