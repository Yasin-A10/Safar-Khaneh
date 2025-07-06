import 'package:safar_khaneh/core/network/api_client.dart';
import 'package:safar_khaneh/data/real-models/feature_model.dart';

class FeatureService {
  final ApiClient _apiClient = ApiClient();

  Future<List<FeatureModel>> fetchFeatures() async {
    try {
      final response = await _apiClient.get('/residences/features');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        return data.map((item) => FeatureModel.fromJson(item)).toList();
      } else {
        throw Exception('خطا در دریافت امکانات');
      }
    } catch (e) {
      throw Exception('خطای ارتباط با سرور: $e');
    }
  }
}
