import 'package:shamsi_date/shamsi_date.dart';

String convertToJalaliDate(String isoDateString) {
  try {
    final dateTime = DateTime.parse(isoDateString);
    final jalali = Jalali.fromDateTime(dateTime);
    final f =
        '${jalali.year}/${jalali.month.toString().padLeft(2, '0')}/${jalali.day.toString().padLeft(2, '0')}';
    return f;
  } catch (e) {
    return 'تاریخ نامعتبر';
  }
}
