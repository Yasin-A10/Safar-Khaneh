import 'package:dio/dio.dart';
import 'package:safar_khaneh/core/network/api_client.dart';

class LoginService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post(
        'auth/login/',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('ورود ناموفق: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // بررسی خطای دریافتی از سرور
      final errorMessage =
          e.response?.data?['message'] ??
          e.response?.data?['detail'] ??
          'خطا در ورود به حساب';
      throw Exception(errorMessage);
    } catch (e) {
      rethrow;
    }
  }
}
