import 'package:safar_khaneh/core/network/auth_api_client.dart';
import 'package:safar_khaneh/features/profile/data/my_booking_model.dart';

class UserReservationService {
  final AuthApiClient _client = AuthApiClient();

  Future<List<UserReservationModel>> fetchUserReservations() async {
    try {
      final response = await _client.get('users/reservations/');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List data = response.data as List;
        return data.map((item) => UserReservationModel.fromJson(item)).toList();
      } else {
        throw Exception('خطا در دریافت رزروهای کاربر: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در دریافت رزروهای کاربر: $e');
    }
  }
}
