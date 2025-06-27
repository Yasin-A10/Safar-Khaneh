// import 'package:flutter/material.dart';
// import 'package:safar_khaneh/core/constants/colors.dart';

// class InputTextFormField extends StatelessWidget {
//   final bool obscureText;
//   final TextInputType keyboardType;
//   final String label;
//   final TextEditingController? initialValue;
//   final int? minLines;
//   final int? maxLines;
//   final FormFieldValidator<String>? validator;

//   const InputTextFormField({
//     super.key,
//     this.obscureText = false,
//     this.keyboardType = TextInputType.text,
//     required this.label,
//     this.initialValue,
//     this.minLines,
//     this.maxLines,
//     this.validator,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextFormField(
//         controller: initialValue,
//         textAlign: TextAlign.right,
//         textDirection: TextDirection.rtl,
//         obscureText: obscureText,
//         keyboardType: keyboardType,
//         minLines: minLines,
//         maxLines: maxLines ?? 1,
//         validator: validator,
//         style: const TextStyle(fontFamily: 'Vazir'),
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: const TextStyle(color: AppColors.grey500),
//           floatingLabelStyle: const TextStyle(
//             color: AppColors.primary800,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//           contentPadding: const EdgeInsets.symmetric(
//             vertical: 10.0,
//             horizontal: 15.0,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             borderSide: const BorderSide(color: AppColors.grey600, width: 1.5),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             borderSide: const BorderSide(color: AppColors.primary800, width: 2),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             borderSide: const BorderSide(color: AppColors.error100, width: 1.5),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             borderSide: const BorderSide(color: AppColors.error100, width: 2),
//           ),
//           errorStyle: const TextStyle(
//             color: AppColors.error100,
//             fontFamily: 'Vazir',
//             fontSize: 13,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:safar_khaneh/core/constants/colors.dart';

class InputTextFormField extends StatelessWidget {
  final bool obscureText;
  final TextInputType keyboardType;
  final String label;
  final TextEditingController? controller;
  final int? minLines;
  final int? maxLines;
  final FormFieldValidator<String>? validator;

  const InputTextFormField({
    super.key,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.label,
    this.controller,
    this.minLines,
    this.maxLines,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        obscureText: obscureText,
        keyboardType: keyboardType,
        minLines: minLines,
        maxLines: maxLines ?? 1,
        validator: validator,
        style: const TextStyle(fontFamily: 'Vazir'),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: AppColors.grey500,
            fontFamily: 'Vazir',
          ),

          // رنگ لیبل در حالت فوکوس یا خطا به صورت پویا
          floatingLabelStyle: WidgetStateTextStyle.resolveWith((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.error)) {
              return const TextStyle(
                color: AppColors.error100,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Vazir',
              );
            }
            if (states.contains(WidgetState.focused)) {
              return const TextStyle(
                color: AppColors.primary800,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Vazir',
              );
            }
            return const TextStyle(
              color: AppColors.grey500,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Vazir',
            );
          }),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 15.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: AppColors.grey600, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: AppColors.primary800, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: AppColors.error100, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: AppColors.error100, width: 2),
          ),
          errorStyle: const TextStyle(
            color: AppColors.error100,
            fontFamily: 'Vazir',
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
