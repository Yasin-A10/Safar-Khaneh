import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/constants/colors.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      color: Colors.grey[200],
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              text: 'Safar Khaneh',
              style: TextStyle(
                letterSpacing: 3,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary800,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'ما در تلاشیم تا بهترین تجربه را برای شما فراهم کنیم. افتخار ما رضایت شماست!',
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.grey600,
              height: 2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.grey, thickness: 1),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.facebook, color: Colors.blue, size: 28),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Iconsax.global,
                      color: Colors.lightBlue,
                      size: 28,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Iconsax.instagram, color: Colors.pink, size: 28),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '© 2025 تمام حقوق این سایت متعلق به سفر خانه است.',
                style: TextStyle(fontSize: 12.0, color: AppColors.grey400),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }
}
