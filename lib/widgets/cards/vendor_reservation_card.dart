import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/utils/convert_to_jalali.dart';
import 'package:safar_khaneh/core/utils/number_formater.dart';
import 'package:safar_khaneh/features/profile/data/vendor_reservation_model.dart';

class VendorReservationCard extends StatelessWidget {
  final String link;
  final VendorReservationModel vendorReservation;

  const VendorReservationCard({
    super.key,
    required this.vendorReservation,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(link, extra: vendorReservation);
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.white,
              border: Border.all(color: AppColors.grey50, width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'vendorReservation-${vendorReservation.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      vendorReservation.residence!.imageUrl!,
                      fit: BoxFit.cover,
                      height: 165,
                      width: 100,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            vendorReservation.residence!.title!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.grey900,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Iconsax.location,
                                color: AppColors.grey300,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${vendorReservation.residence!.location!.city!.name}, ${vendorReservation.residence!.location!.city!.province!.name}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey300,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
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
                                vendorReservation.residence!.pricePerNight!,
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary800,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Divider(color: AppColors.grey200),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.calendar_1,
                                    color: AppColors.grey500,
                                    size: 20,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'شروع از',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.grey500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              SizedBox(width: 16),
                              Text(
                                formatNumberToPersianWithoutSeparator(
                                  convertToJalaliDate(
                                    vendorReservation.checkIn.toString(),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.grey500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.profile_2user,
                                    color: AppColors.grey500,
                                    size: 20,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'تعداد نفرات',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.grey500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              SizedBox(width: 16),
                              Text(
                                formatNumberToPersianWithoutSeparator(
                                  vendorReservation.residence!.capacity
                                      .toString(),
                                ),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.grey500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            formatNumberToPersianWithoutSeparator(
                              vendorReservation.residence!.avgRating.toString(),
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
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color:
                    vendorReservation.status == 'confirmed'
                        ? AppColors.success200
                        : AppColors.error200,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  vendorReservation.status == 'confirmed'
                      ? 'تایید شده'
                      : 'لغو شده',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
