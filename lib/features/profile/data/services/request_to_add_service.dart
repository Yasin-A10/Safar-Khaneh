import 'dart:io';
import 'package:dio/dio.dart';
import 'package:safar_khaneh/core/network/auth_api_client.dart';

class RequestToAddResidenceService {
  final AuthApiClient _client = AuthApiClient();

  Future<void> requestToAddResidence({
    required String title,
    required String type,
    required String address,
    required double lat,
    required double lng,
    required int cityId,
    required File documentFile,
  }) async {
    try {
      final formData = FormData.fromMap({
        'title': title,
        'type': type,
        'address': address,
        'lat': lat.toString(),
        'lng': lng.toString(),
        'city_id': cityId,
        'document': await MultipartFile.fromFile(
          documentFile.path,
          filename: documentFile.path.split('/').last,
        ),
      });

      final response = await _client.post('users/residences/', data: formData);

      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception('خطا در ثبت اقامتگاه: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در ارسال درخواست اقامتگاه: $e');
    }
  }
}
