import 'package:dio/dio.dart';
import 'package:frontend/core/services/authStorage.dart';

import '../constants/apiConstants.dart';

class ApiClient {
  ApiClient._() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await AuthStorage.instance.getToken();

          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },

        onError: (e, handler) async {
          if (e.response?.statusCode == 401) {
            await AuthStorage.instance.clear();
          }

          return handler.next(e);
        },
      ),
    );
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
