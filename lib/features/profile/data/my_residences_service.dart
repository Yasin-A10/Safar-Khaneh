import 'package:dio/dio.dart';
import 'package:safar_khaneh/core/network/auth_api_client.dart';
import 'package:safar_khaneh/features/search/data/residence_model.dart';

class MyResidenceService {
  final AuthApiClient _apiClient = AuthApiClient();

  Future<List<ResidenceModel>> fetchMyResidences() async {
    try {
      final Response response = await _apiClient.get(
        'users/residences/',
      );

      if (response.statusCode == 200) {
        final List data = response.data as List;
        return data.map((e) => ResidenceModel.fromJson(e)).toList();
      } else {
        throw Exception('خطا در دریافت اقامتگاه‌ها');
      }
    } catch (e) {
      throw Exception('خطای ارتباط با سرور: $e');
    }
  }
}
