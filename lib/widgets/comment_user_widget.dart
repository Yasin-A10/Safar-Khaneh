import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/utils/convert_to_jalali.dart';
import 'package:safar_khaneh/core/utils/number_formater.dart';
import 'package:safar_khaneh/features/profile/data/review_model.dart';

class CommentUserWidget extends StatelessWidget {
  final ReviewModel comment;
  final int maxLines;
  const CommentUserWidget({
    super.key,
    required this.comment,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey300, width: 1.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                comment.residence.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                formatNumberToPersianWithoutSeparator(
                  convertToJalaliDate(comment.createdAt.toString()),
                ),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 6,
                  right: 8,
                  top: 4,
                  bottom: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary800,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      formatNumberToPersianWithoutSeparator(
                        comment.rating ?? '0',
                      ),
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Iconsax.star1,
                      color: AppColors.accentColor,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Divider(color: AppColors.grey300, thickness: 1),
          const SizedBox(height: 8),
          // Text(
          //   comment.text,
          //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          // ),
          Text(
            comment.comment,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
