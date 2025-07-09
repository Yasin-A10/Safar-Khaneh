import 'package:dio/dio.dart';
import 'package:safar_khaneh/core/network/api_client.dart';
import 'package:safar_khaneh/features/search/data/residence_model.dart';

class ResidenceService {
  final ApiClient _apiClient = ApiClient();

  Future<List<ResidenceModel>> fetchResidences({
    String? query,
    int? provinceId,
    int? cityId,
    int? minPrice,
    int? maxPrice,
    List<int>? features,
    bool? isActive,
  }) async {
    try {
      final Response response = await _apiClient.get(
        'residences/',
        queryParams: {
          'q': query,
          'province_id': provinceId,
          'city_id': cityId,
          'min_price': minPrice,
          'max_price': maxPrice,
          'features': features,
          'is_active': isActive,
        },
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
