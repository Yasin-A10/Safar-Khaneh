import 'package:dio/dio.dart';
import 'package:safar_khaneh/core/network/api_client.dart';

class ResetPasswordService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      final response = await _apiClient.post(
        'auth/reset-password/',
        data: {'token': token, 'new_password': newPassword},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'status': 'success',
          'message': 'رمز عبور با موفقیت تغییر یافت',
        };
      } else {
        throw Exception('تغییر رمز ناموفق: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // بررسی خطای دریافتی از سرور
      final errorMessage =
          e.response?.data?['message'] ??
          e.response?.data?['detail'] ??
          'خطا در تغییر رمز عبور';
      throw Exception(errorMessage);
    } catch (e) {
      rethrow;
    }
  }
}
