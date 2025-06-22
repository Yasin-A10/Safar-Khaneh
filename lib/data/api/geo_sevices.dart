import 'package:dio/dio.dart';
import 'package:safar_khaneh/core/network/api_client.dart';
import 'package:safar_khaneh/features/search/data/residence_model.dart';

class GeoService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Province>> fetchProvinces() async {
    try {
      final Response response = await _apiClient.get('geo/provinces/');
      final List data = response.data;
      return data.map((item) => Province.fromJson(item)).toList();
    } catch (e) {
      print('خطا در دریافت استان‌ها: $e');
      rethrow;
    }
  }

  Future<List<City>> fetchCitiesByProvince(int provinceId) async {
    try {
      final Response response =
          await _apiClient.get('geo/provinces/$provinceId/cities/');
      final List data = response.data;
      return data.map((item) => City.fromJson(item)).toList();
    } catch (e) {
      print('خطا در دریافت شهرها: $e');
      rethrow;
    }
  }
}
