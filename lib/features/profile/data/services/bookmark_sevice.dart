import 'package:safar_khaneh/core/network/auth_api_client.dart';
import 'package:safar_khaneh/features/search/data/models/bookmark_residence_model.dart';

class BookmarkService {
  final AuthApiClient _client = AuthApiClient();

  Future<List<BookmarkedResidenceModel>> fetchBookmarks() async {
    try {
      final response = await _client.get('users/bookmarks/');

      if (response.statusCode == 200) {
        final List data = response.data as List;
        return data
            .map((json) => BookmarkedResidenceModel.fromJson(json))
            .toList();
      } else {
        throw Exception('خطا در دریافت اقامتگاه‌های بوک‌مارک‌شده');
      }
    } catch (e) {
      throw Exception('خطا در ارتباط با سرور: $e');
    }
  }

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

  Future<void> removeBookmark(int bookmarkId) async {
    try {
      final response = await _client.delete('bookmarks/$bookmarkId/remove/');
      if ([200, 201, 204].contains(response.statusCode)) {
        return;
      } else {
        throw Exception(
          'خطا در حذف اقامتگاه از علاقه‌مندی‌ها: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('خطا در حذف اقامتگاه از علاقه‌مندی‌ها: $e');
    }
  }
}
