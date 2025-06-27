class AppValidators {
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
    if (value == null || value.trim().isEmpty) {
      return '$fieldName نمی‌تواند خالی باشد';
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
}
