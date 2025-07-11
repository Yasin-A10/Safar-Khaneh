import 'package:safar_khaneh/core/network/auth_api_client.dart';
import 'package:safar_khaneh/features/profile/data/vendor_reservation_model.dart';

class VendorReservationService {
  final AuthApiClient _client = AuthApiClient();

  Future<List<VendorReservationModel>> fetchVendorReservations(
    int residenceId,
  ) async {
    try {
      final response = await _client.get(
        'users/residences/$residenceId/reservations/',
      );

      if (response.statusCode == 200) {
        final List data = response.data as List;
        return data
            .map((item) => VendorReservationModel.fromJson(item))
            .toList();
      } else {
        throw Exception(
          'خطا در دریافت رزروهای اقامتگاه: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('خطا در دریافت رزروهای اقامتگاه: $e');
    }
  }
}
