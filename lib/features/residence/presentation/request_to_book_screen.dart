import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/config/router/app_router.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/utils/number_formater.dart';
import 'package:safar_khaneh/core/utils/validators.dart';
import 'package:safar_khaneh/features/residence/data/models/calendar_model.dart';
import 'package:safar_khaneh/features/residence/data/services/calendar_service.dart';
import 'package:safar_khaneh/features/residence/data/services/reservation_calculate_service.dart';
import 'package:safar_khaneh/features/search/data/models/residence_model.dart';
import 'package:safar_khaneh/widgets/button.dart';
import 'package:safar_khaneh/widgets/inputs/text_form_field.dart';
import 'package:safar_khaneh/widgets/persian_calendar.dart';
import 'package:shamsi_date/shamsi_date.dart';

class RequestToBookScreen extends StatefulWidget {
  final ResidenceModel residence;

  const RequestToBookScreen({super.key, required this.residence});

  @override
  State<RequestToBookScreen> createState() => _RequestToBookScreenState();
}

class _RequestToBookScreenState extends State<RequestToBookScreen> {
  final _discountCodeFormKey = GlobalKey<FormState>();
  ReservationCalendarService reservationCalendarService =
      ReservationCalendarService();
  ReservationCalculateService reservationCalculateService =
      ReservationCalculateService();
  late Future<List<CalendarModel>> _futureCalendar;

  TextEditingController discountCodeController = TextEditingController();

  @override
  void initState() {
    _futureCalendar = reservationCalendarService.fetchReservationCalendar(
      widget.residence.id!,
    );
    discountCodeController.text = '';
    super.initState();
  }

  Jalali? selectedStartDate;
  Jalali? selectedEndDate;
  bool _isLoading = false;

  Future<void> _calculatePrice(
    context, {
    required String checkIn,
    required String checkOut,
    required int residenceId,
  }) async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (selectedStartDate == null || selectedEndDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Text(
              'لطفاً تاریخ را انتخاب کنید',
              textDirection: TextDirection.rtl,
            ),
            backgroundColor: AppColors.warning200,
            duration: const Duration(seconds: 3),
          ),
        );
      } else {
        final result = await reservationCalculateService.calculatePrice(
          discountCode:
              discountCodeController.text.isNotEmpty
                  ? discountCodeController.text
                  : '',
          residenceId: residenceId,
          checkIn: checkIn,
          checkOut: checkOut,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Text(
              'اطلاعات رزرو با موفقیت ثبت شد',
              textDirection: TextDirection.rtl,
            ),
            backgroundColor: AppColors.success200,
            duration: const Duration(seconds: 3),
          ),
        );
        GoRouter.of(navigatorKey.currentContext!).push(
          '/residence/${widget.residence.id}/checkout',
          extra: CheckoutArguments(
            residence: widget.residence,
            calculationResult: result,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text('خطایی رخ داد', textDirection: TextDirection.rtl),
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

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.white,
          title: const Text('درخواست رزرو'),
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FutureBuilder(
                  future: _futureCalendar,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    return PersianTableCalendar(
                      calendarData: snapshot.data!,
                      onRangeSelected: (start, end) {
                        setState(() {
                          selectedStartDate = start;
                          selectedEndDate = end;
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 8),
                const Divider(color: AppColors.grey200),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'اطلاعات پرداخت',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'قیمت هر شب',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey400,
                          ),
                        ),
                        Text(
                          formatNumberToPersian(
                            widget.residence.pricePerNight!,
                          ),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'هزینه نظافت',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey400,
                          ),
                        ),
                        Text(
                          formatNumberToPersian(
                            widget.residence.cleaningPrice!,
                          ),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'هزینه سرویس',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey400,
                          ),
                        ),
                        Text(
                          formatNumberToPersian(
                            widget.residence.servicesPrice!,
                          ),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(color: AppColors.grey200),
                  ],
                ),
                const SizedBox(height: 24),
                OutlinedButton(
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
                                    MediaQuery.of(context).viewInsets.bottom,
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
                                            'کد تخفیف خود را وارد کنید',
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
                                      Form(
                                        key: _discountCodeFormKey,
                                        child: InputTextFormField(
                                          label: 'کد تخفیف',
                                          keyboardType: TextInputType.number,
                                          controller: discountCodeController,
                                          validator: (value) {
                                            return AppValidator.userName(
                                              value,
                                              fieldName: 'کد تخفیف',
                                            );
                                          },
                                        ),
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
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.error200,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Button(
                                              label: 'اعمال کد تخفیف',
                                              onPressed: () {
                                                if (_discountCodeFormKey
                                                    .currentState!
                                                    .validate()) {
                                                  discountCodeController.text
                                                      .toString();
                                                  context.pop();
                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        'کد تخفیف با موفقیت اعمال شد',
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
                                  ),
                                ),
                              ),
                            ),
                          ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary800),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    'کد تخفیف',
                    style: TextStyle(
                      color: AppColors.primary800,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
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
            onPressed: () {
              _calculatePrice(
                context,
                checkIn:
                    selectedStartDate!
                        .toDateTime()
                        .toIso8601String()
                        .split('T')
                        .first,
                checkOut:
                    selectedEndDate!
                        .toDateTime()
                        .toIso8601String()
                        .split('T')
                        .first,
                residenceId: widget.residence.id!,
              );
            },
            label: 'درخواست رزرو',
            width: double.infinity,
            isLoading: _isLoading,
            enabled: !_isLoading,
          ),
        ),
      ),
    );
  }
}
