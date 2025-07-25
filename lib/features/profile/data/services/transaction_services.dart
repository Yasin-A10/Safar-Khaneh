import 'package:safar_khaneh/core/network/auth_api_client.dart';
import 'package:safar_khaneh/features/profile/data/models/transaction_model.dart';

class TransactionService {
  final AuthApiClient _client = AuthApiClient();

  Future<PayoutModel> fetchPayoutInfo(int residenceId) async {
    try {
      final response = await _client.get(
        'users/residences/$residenceId/calc-payout/',
      );

      if (response.statusCode == 200) {
        return PayoutModel.fromJson(response.data);
      } else {
        throw Exception('خطا در دریافت اطلاعات پرداخت');
      }
    } catch (e) {
      throw Exception('خطا در ارتباط با سرور: $e');
    }
  }

  Future<Map<String, dynamic>> sendPayoutRequest(int residenceId) async {
    try {
      final response = await _client.post(
        'users/residences/$residenceId/payout/',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'status': 'success'};
      } else {
        throw Exception('خطا در ارسال درخواست پرداخت: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطای ارتباط با سرور در ارسال درخواست پرداخت: $e');
    }
  }

  Future<List<TransactionModel>> fetchTransactions(int residenceId) async {
    try {
      final response = await _client.get(
        'users/residences/$residenceId/payments/',
      );

      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((e) => TransactionModel.fromJson(e)).toList();
      } else {
        throw Exception('خطا در دریافت تراکنش‌ها: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در دریافت لیست تراکنش‌ها: $e');
    }
  }
}
