import 'package:safar_khaneh/core/network/auth_api_client.dart';
import 'package:safar_khaneh/features/residence/data/calendar_model.dart';

class ReservationCalendarService {
  final AuthApiClient _client = AuthApiClient();

  Future<List<CalendarModel>> fetchReservationCalendar(int residenceId) async {
    try {
      final response = await _client.get(
        'residences/$residenceId/reservation-calender/',
      );

      if (response.statusCode == 200) {
        final List data = response.data['calendar'];
        return data.map((json) => CalendarModel.fromJson(json)).toList();
      } else {
        throw Exception('خطا در دریافت تقویم رزرو: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در دریافت تقویم رزرو: $e');
    }
  }
}
