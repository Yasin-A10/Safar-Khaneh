import 'package:safar_khaneh/core/network/auth_api_client.dart';

class ReservationCreateService {
  final AuthApiClient _client = AuthApiClient();

  Future<Map<String, dynamic>> createReservation({
    required String discountCode,
    required int residenceId,
    required String checkIn,
    required String checkOut,
    required int guestCount,
    required String method,
  }) async {
    try {
      final response = await _client.post(
        'reservations/create/',
        data: {
          'discount_code': discountCode,
          'residence_id': residenceId,
          'check_in': checkIn,
          'check_out': checkOut,
          'guest_count': guestCount,
          'method': method,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'status': 'success',
          'message': 'رمز عبور با موفقیت تغییر یافت',
        };
      } else {
        throw Exception('خطا در ثبت رزرو: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در ثبت رزرو: $e');
    }
  }
}
