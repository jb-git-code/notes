import 'package:dio/dio.dart';
import 'package:frontend/core/exceptions/apiExceptions.dart';

import '../../../core/network/apiClient.dart';
import '../../../core/services/authStorage.dart';

import '../models/loginResponse.dart';

class AuthRepository {
  final Dio _dio = ApiClient.instance.dio;

  final AuthStorage _storage = AuthStorage.instance;

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        "/auth/login",
        data: {"email": email, "password": password},
      );

      final loginResponse = LoginResponse.fromJson(response.data);

      await _storage.saveToken(loginResponse.token);

      return loginResponse;
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          throw const ApiException("Connection timed out.");

        case DioExceptionType.receiveTimeout:
          throw const ApiException("Server took too long to respond.");

        case DioExceptionType.connectionError:
          throw const ApiException("No internet connection.");

        case DioExceptionType.badResponse:
          final message = e.response?.data["message"];

          throw ApiException(message ?? "Request failed.");

        default:
          throw const ApiException("Unexpected error.");
      }
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await _dio.post(
      '/auth/register',
      data: {"name": name, "email": email, "password": password},
    );
  }

  Future<void> logout() async {
    await _storage.deleteToken();
  }

  Future<String?> getToken() async {
    return await _storage.getToken();
  }
}
