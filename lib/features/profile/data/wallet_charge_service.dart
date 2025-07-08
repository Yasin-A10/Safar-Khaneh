import 'package:safar_khaneh/core/network/auth_api_client.dart';

class ChargeService {
  final AuthApiClient _client = AuthApiClient();

  Future<String> chargeAccount({required int amount}) async {
    final response = await _client.post(
      'users/payments/charge/',
      data: {'amount': amount},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final payUrl = response.data['pay_url'];
      if (payUrl != null && payUrl is String) {
        return payUrl;
      } else {
        throw Exception('لینک پرداخت دریافت نشد');
      }
    } else {
      throw Exception('خطا در شارژ حساب: ${response.statusCode}');
    }
  }
}
