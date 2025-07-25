import 'package:dio/dio.dart';
import 'package:safar_khaneh/core/network/api_client.dart';
import 'package:safar_khaneh/core/network/auth_api_client.dart';
import 'package:safar_khaneh/core/network/secure_token_storage.dart';
import 'package:safar_khaneh/features/search/data/models/residence_model.dart';

abstract class BaseApiClient {
  Future<Response> get(String path, {Map<String, dynamic>? queryParams});
}

class ResidenceService {
  Future<List<ResidenceModel>> fetchResidences({
    String? query,
    int? provinceId,
    int? cityId,
    int? minPrice,
    int? maxPrice,
    List<int>? features,
    bool? isActive,
  }) async {
    final hasToken = await TokenStorage.hasAccessToken();

    final BaseApiClient dioClient = hasToken ? AuthApiClient() : ApiClient();

    try {
      final Response response = await dioClient.get(
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
