import 'package:dio/dio.dart';
import 'package:safar_khaneh/core/network/api_client.dart';

class VerifyEmailService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> verifyEmail({
    required String token,
  }) async {
    try {
      final response = await _apiClient.post(
        'auth/verify-email/',
        data: {'token': token},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'status': 'success',
          'message': 'ایمیل با موفقیت تایید شد',
        };
      } else {
        return {
          'status': 'error',
          'message': 'تایید ایمیل ناموفق: ${response.statusCode}',
        };
      }
    } on DioException catch (e) {
      // بررسی خطای دریافتی از سرور
      final errorMessage =
          e.response?.data?['message'] ??
          e.response?.data?['detail'] ??
          'خطا در تایید ایمیل';
      throw Exception(errorMessage);
    } catch (e) {
      rethrow;
    }
  }
}
