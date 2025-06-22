import 'package:dio/dio.dart';
import 'package:safar_khaneh/core/network/api_client.dart';
import 'package:safar_khaneh/features/search/data/residence_model.dart';

class ResidenceService {
  final ApiClient _apiClient = ApiClient();

  Future<List<ResidenceModel>> fetchResidences({String? query}) async {
    try {
      final Response response = await _apiClient.get(
        'residences/',
        queryParams: query != null ? {'q': query} : null,
      );

      if (response.statusCode == 200) {
        final List data = response.data as List;
        return data.map((e) => ResidenceModel.fromJson(e)).toList();
      } else {
        throw Exception('خطا در دریافت اقامتگاه‌ها');
      }
    } catch (e) {
      print('Error fetching residences: $e');
      rethrow;
    }
  }
}
