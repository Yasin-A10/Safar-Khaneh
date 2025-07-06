import 'package:safar_khaneh/core/network/auth_api_client.dart';
import 'package:safar_khaneh/features/profile/data/profile_model.dart';

class ProfileService {
  final AuthApiClient _client = AuthApiClient();

  Future<ProfileModel> fetchProfile() async {
    try {
      final response = await _client.get('users/get-me/');
      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data);
      } else {
        throw Exception('خطا در دریافت اطلاعات کاربر');
      }
    } catch (e) {
      throw Exception('خطا در دریافت اطلاعات پروفایل: $e');
    }
  }
}
