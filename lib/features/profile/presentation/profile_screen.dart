import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/utils/number_formater.dart';
import 'package:safar_khaneh/core/utils/validators.dart';
import 'package:safar_khaneh/features/auth/data/models/logout_service.dart';
import 'package:safar_khaneh/features/profile/data/profile_model.dart';
import 'package:safar_khaneh/features/profile/data/profile_services.dart';
import 'package:safar_khaneh/features/profile/data/wallet_charge_service.dart';
import 'package:safar_khaneh/widgets/button.dart';
import 'package:safar_khaneh/widgets/inputs/text_form_field.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _walletChargeFormKey = GlobalKey<FormState>();
  final LogoutService logoutService = LogoutService();
  final ProfileService profileService = ProfileService();
  final ChargeService chargeService = ChargeService();

  final TextEditingController _walletChargeController = TextEditingController();

  late Future<ProfileModel> _futureProfile;

  @override
  void initState() {
    super.initState();
    _futureProfile = profileService.fetchProfile();
  }

  bool _isLoading = false;
  bool _isLoadingCharge = false;

  void handleLogout(context) async {
    try {
      setState(() {
        _isLoading = true;
      });
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
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleChargeWallet(context) async {
    if (!_walletChargeFormKey.currentState!.validate()) return;

    setState(() {
      _isLoadingCharge = true;
    });

    try {
      final url = await chargeService.chargeAccount(
        amount: int.parse(_walletChargeController.text),
      );

      final canLaunch = await canLaunchUrlString(url);
      if (canLaunch) {
        await launchUrlString(url, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('امکان باز کردن لینک پرداخت وجود ندارد');
      }
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
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingCharge = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: _futureProfile,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                return Column(
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
                              snapshot.data?.fullName ?? '',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColors.grey900,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              snapshot.data?.email ?? '',
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
                            context.push(
                              '/profile/personal_info',
                              extra: snapshot.data,
                            );
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
                              '${formatNumberToPersian(snapshot.data?.walletBalance ?? 0)} تومان',
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
                                        bottom:
                                            MediaQuery.of(
                                              context,
                                            ).viewInsets.bottom,
                                      ), // برای جلوگیری از overlap شدن با کیبورد
                                      child: SingleChildScrollView(
                                        child: Container(
                                          padding: const EdgeInsets.all(16.0),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            mainAxisSize:
                                                MainAxisSize
                                                    .min, // به جای height ثابت
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    'مبلغ شارژ خود را وارد کنید',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          AppColors.primary800,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed:
                                                        () => context.pop(),
                                                    icon: const Icon(
                                                      Iconsax.close_circle,
                                                      color:
                                                          AppColors.primary800,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 12),
                                              Form(
                                                key: _walletChargeFormKey,
                                                child: InputTextFormField(
                                                  label: 'مبلغ شارژ',
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator: (value) {
                                                    return AppValidator.price(
                                                      value,
                                                    );
                                                  },
                                                  controller:
                                                      _walletChargeController,
                                                ),
                                              ),
                                              const SizedBox(height: 24),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  OutlinedButton(
                                                    onPressed:
                                                        () => context.pop(),
                                                    style: OutlinedButton.styleFrom(
                                                      side: const BorderSide(
                                                        color:
                                                            AppColors.error200,
                                                        width: 2,
                                                      ),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8,
                                                            ),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                            vertical: 10,
                                                          ),
                                                    ),
                                                    child: const Text(
                                                      'انصراف',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.error200,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    child: Button(
                                                      label: 'پرداخت',
                                                      onPressed: () {
                                                        _handleChargeWallet(
                                                          context,
                                                        );
                                                      },
                                                      isLoading:
                                                          _isLoadingCharge,
                                                      enabled:
                                                          !_isLoadingCharge,
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
                  ],
                );
              },
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
                      const Spacer(),
                      const Icon(
                        Iconsax.arrow_left_2,
                        color: AppColors.grey600,
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
                      const Spacer(),
                      const Icon(
                        Iconsax.arrow_left_2,
                        color: AppColors.grey600,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(color: AppColors.grey200),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () => context.push('/profile/comment_list'),
                  child: Row(
                    children: [
                      Icon(Iconsax.message_add, color: AppColors.grey600),
                      const SizedBox(width: 16),
                      Text(
                        'نظرات و امتیازات',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey700,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Iconsax.arrow_left_2,
                        color: AppColors.grey600,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(color: AppColors.grey200),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () => context.push('/profile/chat_list'),
                  child: Row(
                    children: [
                      Icon(Iconsax.message_notif, color: AppColors.grey600),
                      const SizedBox(width: 16),
                      Text(
                        'لیست چت‌ها',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey700,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Iconsax.arrow_left_2,
                        color: AppColors.grey600,
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
                      const Spacer(),
                      const Icon(
                        Iconsax.arrow_left_2,
                        color: AppColors.grey600,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(color: AppColors.grey200),
                const SizedBox(height: 20),
                InkWell(
                  onTap:
                      () => context.push('/profile/request_to_add_residence'),
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
                      const Spacer(),
                      const Icon(
                        Iconsax.arrow_left_2,
                        color: AppColors.grey600,
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
                                      _isLoading
                                          ? const CircularProgressIndicator()
                                          : OutlinedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              handleLogout(context);
                                              if (mounted) context.go('/login');
                                            },
                                            style: OutlinedButton.styleFrom(
                                              side: BorderSide(
                                                color: AppColors.primary800,
                                                width: 2,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
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
      ),
    );
  }
}
