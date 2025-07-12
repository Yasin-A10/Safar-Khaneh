import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _resetTokenKey = 'reset_token';

  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);

    // ✅ فقط برای تست:
    // final a = await _storage.read(key: _accessTokenKey);
    // final r = await _storage.read(key: _refreshTokenKey);
    // print('📦 access_token: $a');
    // print('📦 refresh_token: $r');
  }

  static Future<void> saveResetToken({required String token}) async {
    await _storage.write(key: _resetTokenKey, value: token);
  }
  static Future<String?> getResetToken() async {
    return await _storage.read(key: _resetTokenKey);
  }
  static Future<void> clearResetToken() async {
    await _storage.delete(key: _resetTokenKey);
  }

  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }
  static Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }
  static Future<bool> hasAccessToken() async {
    final accessToken = await getAccessToken();
    if (accessToken == null) {
      return false;
    }
    return true;
  }
  static Future<bool> hasRefreshToken() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) {
      return false;
    }
    return true;
  }
}
