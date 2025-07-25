import 'package:dio/dio.dart';
import 'package:safar_khaneh/core/network/auth_api_client.dart';
import 'package:safar_khaneh/features/profile/data/models/review_model.dart';
import 'package:safar_khaneh/features/residence/data/models/residence_comments_model.dart';
import 'package:safar_khaneh/core/network/api_client.dart';

class CommentsService {
  final AuthApiClient _authApiClient = AuthApiClient();
  final ApiClient _client = ApiClient();

  Future<Map<String, String>> addComment({
    required int residenceId,
    required String comment,
  }) async {
    try {
      final formData = FormData.fromMap({
        'residence_id': residenceId,
        'comment': comment,
      });

      final response = await _authApiClient.post(
        'reviews/comment-only/',
        data: formData,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return {'status': 'success'};
      } else {
        throw Exception('خطا در ثبت نظر: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در ارسال نظر: $e');
    }
  }

  Future<List<CommentModel>> getComments({required int residenceId}) async {
    try {
      final response = await _client.get('reviews/residences/$residenceId/');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List;
        return data.map((e) => CommentModel.fromJson(e)).toList();
      } else {
        throw Exception('خطا در دریافت نظرات: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در دریافت نظرات: $e');
    }
  }

  Future<Map<String, String>> addReservationComment({
    required int reservationId,
    required String comment,
    required int rating,
  }) async {
    try {
      final formData = FormData.fromMap({
        'reservation_id': reservationId,
        'rating': rating,
        'comment': comment,
      });

      final response = await _authApiClient.post('reviews/', data: formData);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return {'status': 'success'};
      } else {
        throw Exception('خطا در ثبت نظر: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در ارسال نظر: $e');
    }
  }

  Future<List<ReviewModel>> getUserComments() async {
    try {
      final response = await _authApiClient.get('reviews/user/');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List;
        return data.map((e) => ReviewModel.fromJson(e)).toList();
      } else {
        throw Exception('خطا در دریافت نظرات: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در دریافت نظرات: $e');
    }
  }
}
