import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/utils/number_formater.dart';

class DatePicker extends StatefulWidget {
  final Function(Jalali start, Jalali end) onRangeSelected;

  const DatePicker({super.key, required this.onRangeSelected});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  Jalali? _startDate;
  Jalali? _endDate;

  Future<void> _pickStartDate() async {
    final picked = await showPersianDatePicker(
      context: context,
      initialDate: _startDate ?? Jalali.now(),
      firstDate: Jalali(1400, 1),
      lastDate: Jalali(1500, 12),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
        if (_endDate != null && _endDate!.compareTo(_startDate!) < 0) {
          _endDate = null; // ریست کن اگه تاریخ پایان از شروع کمتره
        }
      });
    }
  }

  Future<void> _pickEndDate() async {
    final picked = await showPersianDatePicker(
      context: context,
      initialDate: _endDate ?? (_startDate ?? Jalali.now()),
      firstDate: _startDate ?? Jalali.now(),
      lastDate: Jalali(1500, 12),
    );
    if (picked != null) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = const TextStyle(fontSize: 16);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'تاریخ رزرو',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                top: 8,
                bottom: 4,
              ),
              decoration: BoxDecoration(
                color: AppColors.grey50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'تاریخ شروع',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey600,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _pickStartDate,
                    icon: const Icon(Iconsax.calendar_2),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.grey400,
                    ),
                    label: Text(
                      _startDate != null
                          ? formatNumberToPersianWithoutSeparator(
                            _startDate!.formatCompactDate(),
                          )
                          : 'انتخاب',
                      style: textStyle,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Container(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                top: 8,
                bottom: 4,
              ),
              decoration: BoxDecoration(
                color: AppColors.grey50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'تاریخ پایان',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey600,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _pickEndDate,
                    icon: const Icon(Iconsax.calendar_2),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.grey400,
                    ),
                    label: Text(
                      _endDate != null
                          ? formatNumberToPersianWithoutSeparator(
                            _endDate!.formatCompactDate(),
                          )
                          : 'انتخاب',
                      style: textStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
