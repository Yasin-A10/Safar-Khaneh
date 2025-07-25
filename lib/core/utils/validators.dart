import 'package:safar_khaneh/features/search/data/models/residence_model.dart';

class AppValidator {
  static String? userName(String? value, {String fieldName = 'نام کاربری'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName نمی‌تواند خالی باشد';
    }
    return null;
  }

  static String? email(String? value, {String fieldName = 'ایمیل'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName نمی‌تواند خالی باشد';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'لطفاً یک $fieldName معتبر وارد کنید';
    }
    return null;
  }

  static String? password(String? value, {String fieldName = 'رمز عبور'}) {
    if (value == null || value.trim().isEmpty || value.length < 8) {
      return '$fieldName باید حداقل ۸ کاراکتر داشته باشد';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return '$fieldName باید حداقل یک حرف کوچک داشته باشد';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return '$fieldName باید حداقل یک حرف بزرگ داشته باشد';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return '$fieldName باید حداقل یک عدد داشته باشد';
    }
    return null;
  }

  static String? phoneNumber(
    String? value, {
    String fieldName = 'شماره همراه',
  }) {
    if (value == null ||
        value.trim().isEmpty ||
        value.length < 11 ||
        value.length > 11) {
      return '$fieldName باید حداقل ۱۱ کاراکتر داشته باشد';
    }

    if (!value.startsWith('09')) {
      return '$fieldName باید با ۰۹ شروع شود';
    }
    return null;
  }

  static String? province(Province? value, {String fieldName = 'استان'}) {
    if (value == null) {
      return '$fieldName نمی‌تواند خالی باشد';
    }
    return null;
  }

  static String? city(City? value, {String fieldName = 'شهر'}) {
    if (value == null) {
      return '$fieldName نمی‌تواند خالی باشد';
    }
    return null;
  }

  static String? type(String? value, {String fieldName = 'نوع'}) {
    if (value == null) {
      return '$fieldName نمی‌تواند خالی باشد';
    }
    return null;
  }

  static String? price(String? value, {String fieldName = 'مبلغ'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName نمی‌تواند خالی باشد';
    }

    final price = int.tryParse(value.replaceAll(',', '').trim());
    if (price == null) {
      return '$fieldName معتبر نیست';
    }

    if (price < 1000) {
      return '$fieldName باید حداقل ۱۰۰۰ تومان باشد';
    }
    return null;
  }

  static String? rating(String? value, {String fieldName = 'امتیاز'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName نمی‌تواند خالی باشد';
    }

    final rating = int.tryParse(value.trim());
    if (rating == null) {
      return '$fieldName معتبر نیست';
    }

    if (rating < 1 || rating > 5) {
      return '$fieldName باید حداقل ۱ و حداکثر ۵ باشد';
    }
    return null;
  }
}
