import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/config/router/app_router.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/utils/convert_to_jalali.dart';
import 'package:safar_khaneh/core/utils/number_formater.dart';
// import 'package:safar_khaneh/features/profile/data/profile_model.dart';
import 'package:safar_khaneh/features/profile/data/services/profile_services.dart';
import 'package:safar_khaneh/features/residence/data/models/checkout_model.dart';
import 'package:safar_khaneh/features/residence/data/services/reservation_create_service.dart';
import 'package:safar_khaneh/features/search/data/residence_model.dart';
import 'package:safar_khaneh/widgets/button.dart';
import 'package:safar_khaneh/widgets/counter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CheckoutScreen extends StatefulWidget {
  final ResidenceModel residence;
  final CheckoutPriceModel calculationResult;
  const CheckoutScreen({
    super.key,
    required this.residence,
    required this.calculationResult,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final ProfileService _walletService = ProfileService();
  final ReservationCreateService _reservationCreateService =
      ReservationCreateService();
  int _walletBalance = 0;

  Future<void> _loadProfile() async {
    final profile = await _walletService.fetchProfile();
    setState(() {
      _walletBalance = profile.walletBalance;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  String _selectedMethod = 'wallet';
  int _guestCount = 1;

  void _handleCheckout(context) async {
    try {
      final response = await _reservationCreateService.createReservation(
        discountCode: widget.calculationResult.discountCode ?? '',
        residenceId: widget.residence.id!,
        checkIn: widget.calculationResult.checkIn!,
        checkOut: widget.calculationResult.checkOut!,
        guestCount: _guestCount,
        method: _selectedMethod,
      );

      if (response['status'] == 'success' && mounted) {
        if (_selectedMethod == 'wallet') {
          if ((widget.calculationResult.finalPrice! / 10) <= _walletBalance) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                content: Text(
                  'پرداخت با موفقیت انجام شد',
                  textDirection: TextDirection.rtl,
                ),
                backgroundColor: AppColors.success200,
                duration: const Duration(seconds: 3),
              ),
            );
            GoRouter.of(navigatorKey.currentContext!).go('/my_bookings');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                content: Text(
                  'موجودی کیف پول کافی نیست',
                  textDirection: TextDirection.rtl,
                ),
                backgroundColor: AppColors.error200,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        } else if (_selectedMethod == 'online') {
          final canLaunch = await canLaunchUrlString(response['pay_url']);
          if (canLaunch) {
            await launchUrlString(
              response['pay_url'],
              mode: LaunchMode.externalApplication,
            );
          } else {
            throw Exception('امکان باز کردن لینک پرداخت وجود ندارد');
          }
        } else if (_selectedMethod == 'cash') {
          GoRouter.of(navigatorKey.currentContext!).go('/payment-success');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Text(
              'امکان باز کردن لینک پرداخت وجود ندارد',
              textDirection: TextDirection.rtl,
            ),
            backgroundColor: AppColors.error200,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text('موجودی کیف پول کافی نیست'),
          action: SnackBarAction(
            textColor: AppColors.error200,
            backgroundColor: AppColors.white,
            label: 'پروفایل',
            onPressed: () {
              GoRouter.of(navigatorKey.currentContext!).go('/profile');
            },
          ),
          backgroundColor: AppColors.error200,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.white,
          title: const Text('بررسی نهایی'),
          actions: [
            IconButton(
              icon: const Icon(Iconsax.arrow_left),
              onPressed: () => context.pop(),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.residence.imageUrl!,
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.residence.title!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.grey900,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Iconsax.location,
                                color: AppColors.grey300,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${widget.residence.location?.city?.name!}, ${widget.residence.location?.city?.province?.name!}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey300,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.grey50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              formatNumberToPersian(
                                widget.residence.pricePerNight!,
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          formatNumberToPersianWithoutSeparator(
                            widget.residence.avgRating.toString(),
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColors.grey500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Iconsax.star1,
                          color: AppColors.accentColor,
                          size: 20,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.white,
                    border: Border.all(color: AppColors.grey100, width: 1),
                  ),
                  child: GuestCounter(
                    min: 1,
                    max: widget.residence.capacity!,
                    onChanged: (value) {
                      setState(() {
                        _guestCount = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.white,
                    border: Border.all(color: AppColors.grey100, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'رزرو شما',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary800,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.calendar_1,
                                color: AppColors.grey500,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'تاریخ شروع ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey500,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            formatNumberToPersianWithoutSeparator(
                              convertToJalaliDate(
                                widget.calculationResult.checkIn!,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.calendar_1,
                                color: AppColors.grey500,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'تاریخ پایان',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey500,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            formatNumberToPersianWithoutSeparator(
                              convertToJalaliDate(
                                widget.calculationResult.checkOut!,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.calendar_1,
                                color: AppColors.grey500,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'تعداد شب‌ها',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey500,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${formatNumberToPersianWithoutSeparator(widget.calculationResult.numNights!.toString())} شب',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.call,
                                color: AppColors.grey500,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'شماره تماس',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey500,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            formatNumberToPersianWithoutSeparator(
                              widget.residence.owner!.phoneNumber.toString(),
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Divider(color: AppColors.grey100, thickness: 1),
                      const SizedBox(height: 16),
                      Text(
                        'اطلاعات پرداخت',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary800,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'هزینه شب‌ها',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            formatNumberToPersian(
                              widget.calculationResult.priceForNights! / 10,
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'هزینه خدمات',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            formatNumberToPersian(
                              widget.calculationResult.servicesPrice! / 10,
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'هزینه نظافت',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            formatNumberToPersian(
                              widget.calculationResult.cleaningPrice! / 10,
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'تخفیف',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            formatNumberToPersian(
                              widget.calculationResult.discountValue! / 10,
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'مبلغ قابل پرداخت',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${formatNumberToPersian(widget.calculationResult.finalPrice! / 10)} تومان',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 20,
            top: 12,
          ),
          decoration: const BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, -4),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Button(
            label: 'درخواست رزرو',
            width: double.infinity,
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: AppColors.white,
                context: context,
                builder:
                    (context) => Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            width: MediaQuery.of(context).size.width,
                            child: StatefulBuilder(
                              builder: (
                                BuildContext context,
                                StateSetter setStateModal,
                              ) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'روش پرداخت خود را انتخاب کنید',
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
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: AppColors.white,
                                        border: Border.all(
                                          color: AppColors.grey100,
                                          width: 1,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          //! کیف پول
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Iconsax.empty_wallet_tick,
                                                    color: AppColors.grey700,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    'کیف پول',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors.grey700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Checkbox(
                                                value:
                                                    _selectedMethod == 'wallet',
                                                onChanged: (_) {
                                                  setStateModal(() {
                                                    // استفاده از setStateModal
                                                    _selectedMethod = 'wallet';
                                                  });
                                                },
                                                activeColor:
                                                    AppColors.primary800,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 24),
                                          //! کارت بانکی
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Iconsax.card_tick_1,
                                                    color: AppColors.grey700,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    'پرداخت با کارت بانکی',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors.grey700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Checkbox(
                                                value:
                                                    _selectedMethod == 'online',
                                                onChanged: (_) {
                                                  setStateModal(() {
                                                    _selectedMethod = 'online';
                                                  });
                                                },
                                                activeColor:
                                                    AppColors.primary800,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 24),
                                          //! پرداخت نقدی
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Iconsax.money,
                                                    color: AppColors.grey700,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    'پرداخت نقدی',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors.grey700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Checkbox(
                                                value:
                                                    _selectedMethod == 'cash',
                                                onChanged: (_) {
                                                  setStateModal(() {
                                                    _selectedMethod = 'cash';
                                                  });
                                                },
                                                activeColor:
                                                    AppColors.primary800,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Button(
                                            label: 'انتخاب',
                                            onPressed: () {
                                              _handleCheckout(context);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
              );
            },
          ),
        ),
      ),
    );
  }
}
