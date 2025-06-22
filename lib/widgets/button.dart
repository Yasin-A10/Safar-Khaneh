import 'package:flutter/material.dart';
import 'package:safar_khaneh/core/constants/colors.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool enabled;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double elevation;
  final Color? backgroundColor;

  const Button({
    super.key,
    required this.label,
    required this.onPressed,
    this.enabled = true,
    this.width,
    this.height,
    this.padding,
    this.borderRadius = 8.0,
    this.elevation = 0,
    this.backgroundColor
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
           backgroundColor: enabled ? backgroundColor ?? AppColors.primary800 : AppColors.grey300,
          foregroundColor: AppColors.white,
          padding:
              padding ??
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 32.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: elevation,
          textStyle: const TextStyle(
            fontSize: 18,
            fontFamily: 'Vazir',
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
