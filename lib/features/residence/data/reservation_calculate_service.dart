import 'package:safar_khaneh/core/network/auth_api_client.dart';

class ReservationCalculateService {
  final AuthApiClient _client = AuthApiClient();

  Future<Map<String, dynamic>> calculatePrice({
    required String discountCode,
    required int residenceId,
    required String checkIn,
    required String checkOut,
  }) async {
    try {
      final response = await _client.post(
        'reservations/calc-price/',
        data: {
          'discount_code': discountCode,
          'residence_id': residenceId,
          'check_in': checkIn,
          'check_out': checkOut,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('خطا در محاسبه قیمت: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در محاسبه قیمت: $e');
    }
  }
}
