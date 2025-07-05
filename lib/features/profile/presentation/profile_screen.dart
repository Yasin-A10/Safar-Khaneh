import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/utils/number_formater.dart';
import 'package:safar_khaneh/features/auth/data/logout_service.dart';
import 'package:safar_khaneh/widgets/button.dart';
import 'package:safar_khaneh/widgets/inputs/text_field.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final LogoutService logoutService = LogoutService();

  void handleLogout(BuildContext context) async {
    try {
      await logoutService.logout();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(e.toString(), textDirection: TextDirection.rtl),
          backgroundColor: AppColors.error200,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'محمد حسینی',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'yasin10@gmail.com',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: AppColors.grey500,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  context.push('/profile/personal_info');
                },
                icon: const Icon(
                  Iconsax.edit,
                  color: AppColors.grey600,
                  size: 28,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'شارژ کیف پول',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${formatNumberToPersian(2400000)} تومان',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: AppColors.grey500,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true, // این خیلی مهمه
                    backgroundColor: AppColors.white,
                    context: context,
                    builder:
                        (context) => Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ), // برای جلوگیری از overlap شدن با کیبورد
                            child: SingleChildScrollView(
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisSize:
                                      MainAxisSize.min, // به جای height ثابت
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'مبلغ شارژ خود را وارد کنید',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primary800,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () => context.pop(),
                                          icon: const Icon(
                                            Iconsax.close_circle,
                                            color: AppColors.primary800,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    InputTextField(
                                      label: 'مبلغ شارژ',
                                      keyboardType: TextInputType.number,
                                    ),
                                    const SizedBox(height: 24),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        OutlinedButton(
                                          onPressed: () => context.pop(),
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                              color: AppColors.error200,
                                              width: 2,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 10,
                                            ),
                                          ),
                                          child: const Text(
                                            'انصراف',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.error200,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Button(
                                            label: 'پرداخت',
                                            onPressed: () {},
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                  );
                },
                icon: const Icon(
                  Iconsax.add_square,
                  color: AppColors.grey500,
                  size: 28,
                ),
              ),
            ],
          ),
          const SizedBox(height: 52),
          Column(
            children: [
              InkWell(
                onTap: () => context.push('/my_bookings'),
                child: Row(
                  children: [
                    Icon(Iconsax.archive_book, color: AppColors.grey600),
                    const SizedBox(width: 16),
                    Text(
                      'رزروهای من',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: AppColors.grey200),
              const SizedBox(height: 20),
              InkWell(
                onTap: () => context.push('/profile/bookmark'),
                child: Row(
                  children: [
                    Icon(Iconsax.heart, color: AppColors.grey600),
                    const SizedBox(width: 16),
                    Text(
                      'پسندیده‌ها',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: AppColors.grey200),
              const SizedBox(height: 20),
              InkWell(
                onTap: () => context.push('/profile/my_residence'),
                child: Row(
                  children: [
                    Icon(Iconsax.home_hashtag, color: AppColors.grey600),
                    const SizedBox(width: 16),
                    Text(
                      'اقامتگاه‌های من',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: AppColors.grey200),
              const SizedBox(height: 20),
              InkWell(
                onTap: () => context.push('/profile/request_to_add_residence'),
                child: Row(
                  children: [
                    Icon(Iconsax.add_circle, color: AppColors.grey600),
                    const SizedBox(width: 16),
                    Text(
                      'ثبت اقامتگاه',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: AppColors.grey200),
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed:
                      () => showDialog(
                        context: context,
                        builder: (context) {
                          return Directionality(
                            textDirection: TextDirection.rtl,
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              title: const Text(
                                'آیا از خروج خود مطمئن هستید؟',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => context.pop(),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.error200,
                                        foregroundColor: AppColors.white,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Vazir',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      child: const Text('بازگشت'),
                                    ),
                                    SizedBox(width: 16),
                                    OutlinedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        handleLogout(context);
                                        context.go('/login');
                                      },
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: AppColors.primary800,
                                          width: 2,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                      ),
                                      child: const Text(
                                        'بله',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primary800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  child: Text(
                    'خروج از حساب کاربری',
                    style: TextStyle(
                      fontFamily: 'Vazir',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.error200,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
