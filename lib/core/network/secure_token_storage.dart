import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureTokenStorage {
  static const _accessTokenKey = 'access_token';

  // ساخت یک نمونه از secure storage
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  /// ذخیره توکن
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  /// دریافت توکن
  static Future<String?> getToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  /// حذف توکن
  static Future<void> deleteToken() async {
    await _storage.delete(key: _accessTokenKey);
  }

  /// حذف همه داده‌های ذخیره‌شده (اختیاری)
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
