import 'package:safar_khaneh/core/network/api_client.dart';
import 'package:safar_khaneh/features/home/data/models/home_page_model.dart';
import 'package:safar_khaneh/features/search/data/services/residence_service.dart';
import 'package:safar_khaneh/core/network/auth_api_client.dart';
import 'package:safar_khaneh/core/network/secure_token_storage.dart';

class HomePageService {
  Future<HomePageModel> fetchHomePageData() async {
    final hasToken = await TokenStorage.hasAccessToken();

    final BaseApiClient dioClient = hasToken ? AuthApiClient() : ApiClient();
    try {
      final response = await dioClient.get('home-page/');
      if (response.statusCode == 200) {
        return HomePageModel.fromJson(response.data);
      } else {
        throw Exception('خطا در دریافت اطلاعات صفحه اصلی');
      }
    } catch (e) {
      throw Exception('خطا در دریافت اطلاعات صفحه اصلی: $e');
    }
  }
}
