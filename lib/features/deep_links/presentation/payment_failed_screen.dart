import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/widgets/button.dart';

class PaymentFailedScreen extends StatelessWidget {
  const PaymentFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Residences/failed_img.jpg',
            width: 130,
            height: 130,
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              'پرداخت با شکست مواجه شد',
              style: TextStyle(
                color: AppColors.error200,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Button(
            onPressed: () {
              context.go('/home');
            },
            label: 'بازگشت به صفحه اصلی',
            backgroundColor: const Color.fromARGB(255, 143, 13, 13),
          ),
        ],
      ),
    );
  }
}
