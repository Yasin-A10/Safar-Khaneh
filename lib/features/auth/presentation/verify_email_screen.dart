import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/widgets/button.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Residences/tick_img.jpg',
            width: 120,
            height: 120,
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              'ایمیل شما با موفقیت تایید شد',
              style: TextStyle(
                color: AppColors.success200,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Button(
            onPressed: () {
              context.go('/login');
            },
            label: 'ورود',
            backgroundColor: const Color.fromARGB(255, 25, 129, 51),
          ),
        ],
      ),
    );
  }
}
