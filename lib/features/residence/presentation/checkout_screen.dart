import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/utils/number_formater.dart';
import 'package:safar_khaneh/features/search/data/residence_model.dart';
import 'package:safar_khaneh/widgets/button.dart';

class CheckoutScreen extends StatefulWidget {
  final ResidenceModel residence;
  const CheckoutScreen({super.key, required this.residence});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedMethod = 'wallet';
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
          color: AppColors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
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
                                formatNumberToPersian(widget.residence.pricePerNight!),
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
                                '1404/07/10',
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
                                '1404/07/15',
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
                                  Iconsax.profile_2user,
                                  color: AppColors.grey500,
                                  size: 20,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'تعداد نفرات',
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
                                '3',
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
                              'مبلغ کل',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.grey500,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              formatNumberToPersian(385000),
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
                              '${formatNumberToPersian(20)}%',
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
                              '${formatNumberToPersian(90000)} تومان',
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
              Button(
                width: double.infinity,
                label: 'انتخاب روش پرداخت',
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
                                  // اضافه کردن StatefulBuilder
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
                                              onPressed:
                                                  () =>
                                                      Navigator.of(
                                                        context,
                                                      ).pop(), // استفاده از Navigator.pop
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
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            color: AppColors.white,
                                            border: Border.all(
                                              color: AppColors.grey100,
                                              width: 1,
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              // کیف پول
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Iconsax
                                                            .empty_wallet_tick,
                                                        color:
                                                            AppColors.grey700,
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        'کیف پول',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              AppColors.grey700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Checkbox(
                                                    value:
                                                        selectedMethod ==
                                                        'wallet',
                                                    onChanged: (_) {
                                                      setStateModal(() {
                                                        // استفاده از setStateModal
                                                        selectedMethod =
                                                            'wallet';
                                                      });
                                                    },
                                                    activeColor:
                                                        AppColors.primary800,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 24),
                                              // کارت بانکی
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Iconsax.card_tick_1,
                                                        color:
                                                            AppColors.grey700,
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        'پرداخت با کارت بانکی',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              AppColors.grey700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Checkbox(
                                                    value:
                                                        selectedMethod ==
                                                        'card',
                                                    onChanged: (_) {
                                                      setStateModal(() {
                                                        // استفاده از setStateModal
                                                        selectedMethod = 'card';
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
                                                  if (selectedMethod != '') {
                                                    print(
                                                      'روش پرداخت انتخاب‌شده: $selectedMethod',
                                                    );
                                                    Navigator.of(
                                                      context,
                                                    ).pop(); // بستن BottomSheet
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                          'لطفاً یک روش پرداخت انتخاب کنید',
                                                        ),
                                                      ),
                                                    );
                                                  }
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
            ],
          ),
        ),
      ),
    );
  }
}
