import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentFailedScreen extends StatelessWidget {
  const PaymentFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'پرداخت با شکست مواجه شد',
              style: TextStyle(
                color: Colors.red,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/home');
            },
            child: const Text('بازگشت به صفحه اصلی'),
          ),
        ],
      ),
    );
  }
}
