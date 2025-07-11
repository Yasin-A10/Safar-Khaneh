import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/utils/number_formater.dart';

class GuestCounter extends StatefulWidget {
  final int min;
  final int max;
  final Function(int) onChanged;

  const GuestCounter({
    super.key,
    this.min = 1,
    this.max = 10,
    required this.onChanged,
  });

  @override
  State<GuestCounter> createState() => _GuestCounterState();
}

class _GuestCounterState extends State<GuestCounter> {
  int _guestCount = 1;

  void _increment() {
    if (_guestCount < widget.max) {
      setState(() {
        _guestCount++;
        widget.onChanged(_guestCount);
      });
    }
  }

  void _decrement() {
    if (_guestCount > widget.min) {
      setState(() {
        _guestCount--;
        widget.onChanged(_guestCount);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'تعداد نفرات',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            _buildCircleButton(
              icon: Iconsax.minus,
              color: AppColors.secondary200,
              iconColor: AppColors.primary800,
              onPressed: _decrement,
              enabled: _guestCount > widget.min,
            ),
            const SizedBox(width: 16),
            Text(
              formatNumberToPersianWithoutSeparator(_guestCount.toString()),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 16),
            _buildCircleButton(
              icon: Iconsax.add,
              color: AppColors.primary800,
              iconColor: AppColors.white,
              onPressed: _increment,
              enabled: _guestCount < widget.max,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onPressed,
    required bool enabled,
  }) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: CircleAvatar(
        radius: 17,
        backgroundColor: enabled ? color : AppColors.grey100,
        child: Icon(icon, color: enabled ? iconColor : AppColors.grey500),
      ),
    );
  }
}
