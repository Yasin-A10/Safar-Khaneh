import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/utils/convert_to_jalali.dart';
import 'package:safar_khaneh/core/utils/number_formater.dart';
import 'package:safar_khaneh/core/utils/validators.dart';
import 'package:safar_khaneh/features/profile/data/models/my_booking_model.dart';
import 'package:safar_khaneh/features/profile/data/services/vendor_reservation_service.dart';
import 'package:safar_khaneh/features/residence/data/comments_service.dart';
import 'package:safar_khaneh/widgets/button.dart';
import 'package:safar_khaneh/widgets/inputs/text_form_field.dart';
import 'package:safar_khaneh/widgets/map.dart';

class BookingDetailsScreen extends StatefulWidget {
  final UserReservationModel reservation;

  const BookingDetailsScreen({super.key, required this.reservation});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  final GlobalKey<FormState> _sendCommentFormKey = GlobalKey<FormState>();

  final VendorReservationService _vendorReservationService =
      VendorReservationService();
  final CommentsService _commentService = CommentsService();

  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _commentController.text = '';
    _ratingController.text = '';
  }

  @override
  void dispose() {
    _commentController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  void _handleCancelReservation(context) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final start = DateTime.parse(widget.reservation.checkIn!);
    final tomorrow = today.add(const Duration(days: 1));
    // final yesterday = today.subtract(const Duration(days: 1));

    if (!start.isAfter(today)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(
            'تاریخ رزرو گذشته است',
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: AppColors.error200,
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    try {
      if (start.isAfter(tomorrow)) {
        await _vendorReservationService.cancelReservation(
          widget.reservation.id!,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Text(
              'رزرو با موفقیت لغو شد',
              textDirection: TextDirection.rtl,
            ),
            backgroundColor: AppColors.success200,
            duration: const Duration(seconds: 3),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Text(
              'امکان لغو رزرو وجود ندارد',
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
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text('خطا در لغو رزرو', textDirection: TextDirection.rtl),
          backgroundColor: AppColors.error200,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void showCommentDialog(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 0,
                bottom: 16,
                left: 16,
                right: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'ارسال نظر',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary800,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Form(
                    key: _sendCommentFormKey,
                    child: Column(
                      children: [
                        InputTextFormField(
                          label: 'امتیاز',
                          keyboardType: TextInputType.number,
                          controller: _ratingController,
                          validator: (value) {
                            return AppValidator.rating(value);
                          },
                        ),
                        const SizedBox(height: 16),
                        InputTextFormField(
                          label: 'نظر',
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          controller: _commentController,
                          validator: (value) {
                            return AppValidator.userName(
                              value,
                              fieldName: 'نظر',
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                              onPressed: () => context.pop(),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: AppColors.error200,
                                  width: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                              ),
                              child: const Text(
                                'بازگشت',
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
                                label: 'ارسال نظر',
                                onPressed: () {
                                  _handleSendComment(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _handleSendComment(context) async {
    if (!_sendCommentFormKey.currentState!.validate()) return;

    try {
      final response = await _commentService.addReservationComment(
        reservationId: widget.reservation.id!,
        comment: _commentController.text,
        rating: int.parse(_ratingController.text),
      );

      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Text(
              'نظر با موفقیت ارسال شد',
              textDirection: TextDirection.rtl,
            ),
            backgroundColor: AppColors.success200,
            duration: const Duration(seconds: 3),
          ),
        );
        GoRouter.of(context).pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text('خطا در ارسال نظر', textDirection: TextDirection.rtl),
          backgroundColor: AppColors.error200,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final start = DateTime.parse(widget.reservation.checkIn!);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.white,
          leading: PopupMenuButton(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              side: BorderSide(color: AppColors.primary800, width: 2),
            ),
            elevation: 8,
            offset: const Offset(0, 48),
            icon: const Icon(Iconsax.menu, color: AppColors.primary800),
            onSelected: (value) {
              if (value == 'deleteReservation') {
                _handleCancelReservation(context);
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'deleteReservation',
                  child: Text(
                    'لغو رزرو',
                    style: TextStyle(
                      color: AppColors.error200,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ];
            },
          ),
          title: const Text('اطلاعات اقامتگاه رزرو شده'),
          actions: [
            IconButton(
              icon: const Icon(Iconsax.arrow_left),
              onPressed: () => context.pop(),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: 'bookedResidence-${widget.reservation.id}',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                widget.reservation.residence!.imageUrl!,
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.reservation.residence!.title!,
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
                                      '${widget.reservation.residence!.location!.city!.name}, ${widget.reservation.residence!.location!.city!.province!.name}',
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
                                      widget
                                          .reservation
                                          .residence!
                                          .pricePerNight!,
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
                                  widget.reservation.residence?.avgRating,
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
                      const SizedBox(height: 24),

                      if (widget.reservation.residence?.location?.lat != null &&
                          widget.reservation.residence?.location?.lng != null)
                        SizedBox(
                          height: 300,
                          child: MapWidget(
                            latitude:
                                widget.reservation.residence!.location!.lat!
                                    .toString(),
                            longitude:
                                widget.reservation.residence!.location!.lng!
                                    .toString(),
                          ),
                        )
                      else
                        const Text('مختصات موجود نیست'),

                      const SizedBox(height: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.timer_start,
                                    color: AppColors.grey400,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'تاریخ شروع',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.grey400,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                formatNumberToPersianWithoutSeparator(
                                  convertToJalaliDate(
                                    widget.reservation.checkIn!,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.grey500,
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
                                    Iconsax.timer_pause,
                                    color: AppColors.grey400,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'تاریخ پایان',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.grey400,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                formatNumberToPersianWithoutSeparator(
                                  convertToJalaliDate(
                                    widget.reservation.checkOut!,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.grey500,
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
                                    Iconsax.personalcard,
                                    color: AppColors.grey400,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'مدیریت',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.grey400,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                widget.reservation.residence?.owner?.fullName ??
                                    'نامشخص',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.grey500,
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
                                    color: AppColors.grey400,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'تعداد نفرات',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.grey400,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                formatNumberToPersianWithoutSeparator(
                                  widget.reservation.residence?.capacity,
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.grey500,
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
                                    color: AppColors.grey400,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'شماره تماس',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.grey400,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                formatNumberToPersianWithoutSeparator(
                                  widget
                                      .reservation
                                      .residence
                                      ?.owner
                                      ?.phoneNumber,
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.grey500,
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
                                    Iconsax.status,
                                    color: AppColors.grey400,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'وضعیت رزرو',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.grey400,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                widget.reservation.status == 'confirmed'
                                    ? 'تایید شده'
                                    : widget.reservation.status == 'cancelled'
                                    ? 'لغو شده'
                                    : 'پرداخت ناموفق',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      widget.reservation.status == 'confirmed'
                                          ? AppColors.success200
                                          : widget.reservation.status ==
                                              'cancelled'
                                          ? AppColors.error200
                                          : AppColors.warning200,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (widget.reservation.hasReview == true)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Iconsax.message_question,
                                      color: AppColors.grey400,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'وضعیت نظر',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.grey400,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'ثبت شده',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.success200,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                if (widget.reservation.hasReview == false &&
                    widget.reservation.status == 'confirmed' &&
                    !start.isAfter(today))
                  Button(
                    label: 'ارسال نظر',
                    width: double.infinity,
                    onPressed: () {
                      showCommentDialog(context);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
