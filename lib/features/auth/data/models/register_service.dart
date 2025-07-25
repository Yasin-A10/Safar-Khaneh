import 'package:dio/dio.dart';
import 'package:safar_khaneh/core/network/api_client.dart';

class RegisterService {
  final ApiClient _apiClient = ApiClient();

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post(
        'auth/register/',
        data: {'full_name': fullName, 'email': email, 'password': password},
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('ثبت‌نام موفق');
        // مثلاً توکن یا پیام موفقیت رو برگردون
      } else {
        throw Exception('ثبت‌نام ناموفق: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // می‌تونی خطای بک‌اند رو اینجا دقیق‌تر هندل کنی
      final errorMsg = e.response?.data['detail'] ?? 'خطا در ثبت‌نام';
      throw Exception(errorMsg);
    }
  }
}
