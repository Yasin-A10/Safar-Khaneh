import 'package:intl/intl.dart';

String formatNumberToPersian(num number, {String separator = ','}) {
  final formatter = NumberFormat('#,###');
  String formatted = formatter.format(number);

  formatted = _convertToPersianDigits(formatted);

  if (separator != ',') {
    formatted = formatted.replaceAll(',', separator);
  }

  return formatted;
}

String formatNumberToPersianWithoutSeparator(dynamic number) {
  String formatted = number.toString();

  formatted = _convertToPersianDigits(formatted);

  return formatted;
}

String _convertToPersianDigits(String input) {
  const englishDigits = '0123456789';
  const persianDigits = '۰۱۲۳۴۵۶۷۸۹';
  return input
      .split('')
      .map((char) {
        final index = englishDigits.indexOf(char);
        return index != -1 ? persianDigits[index] : char;
      })
      .join('');
}
