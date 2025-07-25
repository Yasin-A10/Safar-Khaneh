import 'package:safar_khaneh/core/network/auth_api_client.dart';
import 'package:safar_khaneh/features/profile/data/models/profile_model.dart';

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

  Future<void> updateProfile({
    required String fullName,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final response = await _client.put(
        'users/profile/',
        data: {
          'full_name': fullName,
          'phone_number': phoneNumber,
          'password': password,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('خطا در به‌روزرسانی پروفایل');
      }
    } catch (e) {
      throw Exception('خطا در به‌روزرسانی اطلاعات پروفایل: $e');
    }
  }

  Future<void> chargeWallet({required int amount}) async {
    try {
      final response = await _client.post(
        'users/payments/charge/',
        data: {'amount': amount},
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('شارژ کیف پول با خطا مواجه شد');
      }
    } catch (e) {
      throw Exception('خطا در شارژ کیف پول: $e');
    }
  }
}
