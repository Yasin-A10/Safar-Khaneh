import 'package:flutter/material.dart';
import 'package:safar_khaneh/core/constants/colors.dart';

class AppTheme {
  // رنگ‌های اصلی
  static const Color primaryColor = AppColors.primary800;
  static const Color backgroundColor = AppColors.grey25;

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        surface: AppColors.white,
      ),

      fontFamily: 'Vazir',

      // textTheme: const TextTheme(
      //   displayLarge: TextStyle(
      //     fontSize: 32,
      //     fontWeight: FontWeight.bold,
      //     color: textColor,
      //   ),
      //   titleLarge: TextStyle(
      //     fontSize: 20,
      //     fontWeight: FontWeight.w600,
      //     color: textColor,
      //   ),
      //   bodyMedium: TextStyle(fontSize: 16, color: textColor),
      //   bodySmall: TextStyle(fontSize: 14, color: secondaryTextColor),
      // ),
      scaffoldBackgroundColor: backgroundColor,

      appBarTheme: const AppBarTheme(
        surfaceTintColor: AppColors.white,
        foregroundColor: AppColors.primary800,
        centerTitle: true,
        elevation: 8,
        titleTextStyle: TextStyle(
          color: primaryColor,
          fontFamily: 'Vazir',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: AppColors.grey400,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Vazir',
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Vazir',
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 8,
      ),

      //   elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ElevatedButton.styleFrom(
      //       backgroundColor: primaryColor,
      //       foregroundColor: Colors.white,
      //       textStyle: const TextStyle(
      //         fontFamily: 'Vazir',
      //         fontSize: 16,
      //         fontWeight: FontWeight.w600,
      //       ),
      //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      //     ),
      //   ),

      //   cardTheme: CardTheme(
      //     color: Colors.white,
      //     elevation: 2,
      //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      //   ),
    );
  }

  // static ThemeData get darkTheme {
  //   return ThemeData(
  //     primaryColor: primaryColor,
  //     colorScheme: const ColorScheme.dark(
  //       primary: primaryColor,
  //       secondary: accentColor,
  //       background: Color(0xFF121212),
  //       onPrimary: Colors.white,
  //       onBackground: Colors.white,
  //     ),
  //     scaffoldBackgroundColor: const Color(0xFF121212),
  //     fontFamily: 'Vazir',
  //     textTheme: const TextTheme(
  //       displayLarge: TextStyle(
  //         fontSize: 32,
  //         fontWeight: FontWeight.bold,
  //         color: Colors.white,
  //       ),
  //       titleLarge: TextStyle(
  //         fontSize: 20,
  //         fontWeight: FontWeight.w600,
  //         color: Colors.white,
  //       ),
  //       bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
  //       bodySmall: TextStyle(fontSize: 14, color: Colors.grey),
  //     ),
  //     appBarTheme: const AppBarTheme(
  //       backgroundColor: Color(0xFF1E1E1E),
  //       foregroundColor: Colors.white,
  //       elevation: 4,
  //       titleTextStyle: TextStyle(
  //         fontFamily: 'Vazir',
  //         fontSize: 20,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //     bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //       backgroundColor: const Color(0xFF1E1E1E),
  //       selectedItemColor: primaryColor,
  //       unselectedItemColor: Colors.grey,
  //       selectedLabelStyle: const TextStyle(
  //         fontFamily: 'Vazir',
  //         fontWeight: FontWeight.bold,
  //         fontSize: 14,
  //       ),
  //       unselectedLabelStyle: const TextStyle(
  //         fontFamily: 'Vazir',
  //         fontWeight: FontWeight.normal,
  //         fontSize: 12,
  //       ),
  //       showSelectedLabels: true,
  //       showUnselectedLabels: true,
  //       elevation: 8,
  //     ),
  //     elevatedButtonTheme: ElevatedButtonThemeData(
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: primaryColor,
  //         foregroundColor: Colors.white,
  //         textStyle: const TextStyle(
  //           fontFamily: 'Vazir',
  //           fontSize: 16,
  //           fontWeight: FontWeight.w600,
  //         ),
  //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //       ),
  //     ),
  //     cardTheme: CardTheme(
  //       color: const Color(0xFF1E1E1E),
  //       elevation: 2,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //     ),
  //   );
  // }
}
