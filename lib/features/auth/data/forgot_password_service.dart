import 'package:dio/dio.dart';
import 'package:safar_khaneh/core/network/api_client.dart';

class ForgetPasswordService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> forgotPassword({
    required String email,
  }) async {
    try {
      final response = await _apiClient.post(
        'auth/forgot-password/',
        data: {'email': email},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'status': 'success',
          'message': 'ایمیل با موفقیت فراموشی شد',
        };
      } else {
        throw Exception('خطا در فراموشی رمز عبور: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // بررسی خطای دریافتی از سرور
      final errorMessage =
          e.response?.data?['message'] ??
          e.response?.data?['detail'] ??
          'خطا در فراموشی رمز عبور';
      throw Exception(errorMessage);
    } catch (e) {
      rethrow;
    }
  }
}
