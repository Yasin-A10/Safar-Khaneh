import 'package:dio/dio.dart';
import 'package:safar_khaneh/core/network/api_client.dart';
import 'package:safar_khaneh/core/network/secure_token_storage.dart';

class LogoutService {
  final ApiClient _apiClient = ApiClient();

  Future<void> logout() async {
    try {
      final refreshToken = await TokenStorage.getRefreshToken();

      if (refreshToken == null) {
        throw Exception('رفرش توکن پیدا نشد!');
      }

      final response = await _apiClient.post(
        'auth/logout/',
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        await TokenStorage.clearTokens();
      } else {
        throw Exception('خروج ناموفق: ${response.statusCode}');
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['message'] ??
          e.response?.data?['detail'] ??
          'خطا در خروج از حساب';
      throw Exception(errorMessage);
    } catch (e) {
      rethrow;
    }
  }
}
