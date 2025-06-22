import 'package:flutter/material.dart';
import 'package:safar_khaneh/core/constants/colors.dart';

class InputTextField extends StatelessWidget {
  final bool obscureText;
  final TextInputType keyboardType;
  final String label;
  final TextEditingController? initialValue;
  final int? minLines;
  final int? maxLines;

  const InputTextField({
    super.key,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.label,
    this.initialValue,
    this.minLines,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        obscureText: obscureText,
        keyboardType: keyboardType,
        controller: initialValue,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.grey500),
          floatingLabelStyle: TextStyle(
            color: AppColors.primary800,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: AppColors.grey600, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: AppColors.primary800, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 15.0,
          ),
        ),
      ),
    );
  }
}
