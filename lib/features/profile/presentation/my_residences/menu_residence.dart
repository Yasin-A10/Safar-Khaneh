import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/config/router/app_router.dart';
import 'package:safar_khaneh/core/constants/colors.dart';

class MenuResidence extends StatelessWidget {
  final ResidenceContextModel contextModel;
  const MenuResidence({super.key, required this.contextModel});

  @override
  Widget build(BuildContext context) {
    final residence = contextModel.residence;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(residence.title!),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left),
            onPressed: () => context.pop(),
          ),
        ],
      ),
      body: Container(
        color: AppColors.backgroundColor,
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.grey100, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap:
                    () => context.push(
                      '/profile/my_residence/menu_residence/${residence.id}/edit',
                      extra: residence,
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Iconsax.edit_2),
                          color: AppColors.grey800,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'اطلاعات اقامتگاه',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey800,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Iconsax.arrow_left_2, color: AppColors.grey600),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap:
                    () => context.push(
                      '/profile/my_residence/menu_residence/${residence.id}/reservation_history',
                      extra: contextModel,
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Iconsax.archive_tick),
                          color: AppColors.grey800,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'تاریخچه رزروها',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey800,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Iconsax.arrow_left_2, color: AppColors.grey600),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap:
                    () => context.push(
                      '/profile/my_residence/menu_residence/${residence.id}/transaction',
                      extra: contextModel,
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Iconsax.dollar_square),
                          color: AppColors.grey800,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'گزارش مالی',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey800,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Iconsax.arrow_left_2, color: AppColors.grey600),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap:
                    () => context.push(
                      '/profile/my_residence/menu_residence/${residence.id}/comments',
                      extra: residence,
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Iconsax.message_notif),
                          color: AppColors.grey800,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'نظرات و امتیازات',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey800,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Iconsax.arrow_left_2, color: AppColors.grey600),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
