import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  final Dio _dio;

  ApiClient._internal(this._dio);

  factory ApiClient() {
    final dio = Dio(
      BaseOptions(
        // baseUrl: 'http://10.0.2.2:8000/api/', // for android
        baseUrl: 'http://127.0.0.1:8000/api/', // for ios
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true, // بدنهٔ درخواست (body) رو در لاگ نشون می‌ده
        requestHeader: true, // هدرهای ارسال‌شده در درخواست رو هم نشون می‌ده
        responseBody: true, // بدنهٔ پاسخ دریافتی از سرور رو لاگ می‌کنه
        responseHeader:
            false, // هدرهای پاسخ رو نشون نمی‌ده (false یعنی مخفی کن)
        error: true, // اگر خطایی بیاد، اون رو هم لاگ می‌کنه
        compact: true, // لاگ‌ها رو جمع‌وجور و خلاصه‌تر نشون می‌ده
        maxWidth: 90, // حداکثر عرض هر خط لاگ رو ۹۰ کاراکتر تنظیم می‌کنه
      ),
    );

    return ApiClient._internal(dio);
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) async {
    return await _dio.get(path, queryParameters: queryParams);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) async {
    return await _dio.put(path, data: data);
  }

  Future<Response> delete(String path, {dynamic data}) async {
    return await _dio.delete(path, data: data);
  }
}
