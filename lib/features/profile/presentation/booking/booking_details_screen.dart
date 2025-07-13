import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/utils/convert_to_jalali.dart';
import 'package:safar_khaneh/core/utils/number_formater.dart';
import 'package:safar_khaneh/features/profile/data/my_booking_model.dart';
import 'package:safar_khaneh/widgets/map.dart';

class BookingDetailsScreen extends StatelessWidget {
  final UserReservationModel reservation;

  const BookingDetailsScreen({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.white,
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
            child: Container(
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
                        tag: 'bookedResidence-${reservation.id}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            reservation.residence!.imageUrl!,
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
                              reservation.residence!.title!,
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
                                  '${reservation.residence!.location!.city!.name}, ${reservation.residence!.location!.city!.province!.name}',
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
                                  reservation.residence!.pricePerNight!,
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
                              reservation.residence?.avgRating,
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

                  if (reservation.residence?.location?.lat != null &&
                      reservation.residence?.location?.lng != null)
                    SizedBox(
                      height: 300,
                      child: MapWidget(
                        latitude:
                            reservation.residence!.location!.lat!.toString(),
                        longitude:
                            reservation.residence!.location!.lng!.toString(),
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
                              convertToJalaliDate(reservation.checkIn!),
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
                              convertToJalaliDate(reservation.checkOut!),
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
                            reservation.residence?.owner?.fullName ?? 'نامشخص',
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
                              reservation.residence?.capacity,
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
                              reservation.residence?.owner?.phoneNumber,
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey500,
                            ),
                          ),
                        ],
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
  }
}
