import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/utils/number_formater.dart';
import 'dart:ui';
import 'package:safar_khaneh/data/models/my_residence_model.dart';

class MyResidenceCard extends StatelessWidget {
  final MyResidenceModel residence;
  const MyResidenceCard({super.key, required this.residence});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => context.push(
            '/profile/my_residence/menu_residence/${residence.id}',
            extra: residence,
          ),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Image.asset(
                    residence.backgroundImage,
                    fit: BoxFit.cover,
                    height: 180,
                    width: double.infinity,
                  ),
                  Positioned(
                    top: 8,
                    left: 4,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            color: AppColors.grey400.withValues(alpha: 0.3),
                            padding: const EdgeInsets.only(
                              left: 4,
                              right: 8,
                              top: 4,
                              bottom: 4,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  formatNumberToPersianWithoutSeparator(
                                    residence.rating.toString(),
                                  ),
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Iconsax.star1,
                                  color: AppColors.accentColor,
                                  size: 22,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      residence.title,
                      style: TextStyle(
                        color: AppColors.grey900,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${residence.city}, ${residence.province}',
                      style: TextStyle(fontSize: 14, color: AppColors.grey300),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Iconsax.house,
                              color: AppColors.grey600,
                              size: 16,
                            ),
                            SizedBox(width: 5),
                            Text(
                              formatNumberToPersianWithoutSeparator(
                                residence.roomCount.toString(),
                              ),
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.grey600,
                              ),
                            ),
                            SizedBox(width: 5),
                            const Text(
                              'خواب',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.grey600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '.',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.grey600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Row(
                          children: [
                            Icon(
                              Iconsax.profile_2user,
                              color: AppColors.grey600,
                              size: 16,
                            ),
                            SizedBox(width: 5),
                            const Text(
                              'ظرفیت نفرات: ',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.grey600,
                              ),
                            ),
                            SizedBox(width: 2),
                            Text(
                              formatNumberToPersianWithoutSeparator(
                                residence.capacity.toString(),
                              ),
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.grey600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  '${formatNumberToPersian(residence.price)} تومان',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primary800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
