import 'package:safar_khaneh/core/network/auth_api_client.dart';

class BookmarkService {
  final AuthApiClient _client = AuthApiClient();

  Future<Map<String, dynamic>> addBookmark(int residenceId) async {
    try {
      final response = await _client.post(
        'bookmarks/add/',
        data: {'residence_id': residenceId},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          'خطا در اضافه کردن اقامتگاه به علاقه مندی ها: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('خطا در اضافه کردن اقامتگاه به علاقه مندی ها: $e');
    }
  }

  Future<Map<String, dynamic>> removeBookmark(int bookmarkId) async {
    try {
      final response = await _client.delete(
        'bookmarks/remove/',
        data: {'bookmark_id': bookmarkId},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          'خطا در حذف اقامتگاه از علاقه مندی ها: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('خطا در حذف اقامتگاه از علاقه مندی ها: $e');
    }
  }
}
