import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:safar_khaneh/config/router/app_router.dart';
import 'package:safar_khaneh/core/network/secure_token_storage.dart';

class AuthApiClient {
  final Dio _dio;

  AuthApiClient._internal(this._dio);

  factory AuthApiClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://127.0.0.1:8000/api/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          // 'Authorization': 'Bearer ${TokenStorage.getRefreshToken()}',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenStorage.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            final refreshToken = await TokenStorage.getRefreshToken();
            if (refreshToken != null) {
              try {
                final newTokens = await _refreshToken(refreshToken);
                await TokenStorage.saveTokens(
                  accessToken: newTokens['access'],
                  refreshToken: newTokens['refresh'],
                );

                final newRequest = error.requestOptions;
                newRequest.headers['Authorization'] =
                    'Bearer ${newTokens['access']}';
                final cloneReq = await dio.fetch(newRequest);
                return handler.resolve(cloneReq);
              } catch (e) {
                // 👇 اینجا اضافه کن
                await TokenStorage.clearTokens();

                // برای ریدایرکت به صفحه لاگین
                GoRouter.of(navigatorKey.currentContext!).go('/login');

                return handler.reject(
                  DioException(
                    requestOptions: error.requestOptions,
                    message: 'نشست شما منقضی شده است. لطفاً دوباره وارد شوید.',
                  ),
                );
              }
            } else {
              // اگر رفرش توکن هم نداشتیم
              await TokenStorage.clearTokens();
              GoRouter.of(navigatorKey.currentContext!).go('/login');

              return handler.reject(
                DioException(
                  requestOptions: error.requestOptions,
                  message: 'نشست شما منقضی شده است. لطفاً دوباره وارد شوید.',
                ),
              );
            }
          }

          return handler.next(error);
        },
      ),
    );

    return AuthApiClient._internal(dio);
  }

  static Future<Map<String, dynamic>> _refreshToken(String refreshToken) async {
    final dio = Dio();
    final response = await dio.post(
      'http://127.0.0.1:8000/api/auth/refresh_token/',
      data: {'refresh_token': refreshToken},
      options: Options(
        headers: {
          // 'Authorization': 'Bearer $refreshToken',
          'Accept': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('رفرش توکن ناموفق بود');
    }
  }

  // متدهای عمومی
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

 // onError: (DioException error, handler) async {
        //   // اگر توکن منقضی شده بود
        //   if (error.response?.statusCode == 401) {
        //     final refreshToken = await TokenStorage.getRefreshToken();
        //     if (refreshToken != null) {
        //       try {
        //         final newTokens = await _refreshToken(refreshToken);
        //         await TokenStorage.saveTokens(
        //           accessToken: newTokens['access'],
        //           refreshToken: newTokens['refresh'],
        //         );

        //         // درخواست قبلی را با توکن جدید تکرار کن
        //         final newRequest = error.requestOptions;
        //         newRequest.headers['Authorization'] =
        //             'Bearer ${newTokens['access']}';

        //         final cloneReq = await dio.fetch(newRequest);
        //         return handler.resolve(cloneReq);
        //       } catch (e) {
        //         // در صورت شکست، لاگ‌اوت یا ارور
        //         return handler.reject(
        //           DioException(
        //             requestOptions: error.requestOptions,
        //             message: 'نشست شما منقضی شده است. لطفاً دوباره وارد شوید.',
        //           ),
        //         );
        //       }
        //     }
        //   }

        //   return handler.next(error);
        // },
