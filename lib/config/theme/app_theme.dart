import 'package:flutter/material.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
// import 'package:flutter_chat_core/flutter_chat_core.dart';

class AppTheme {
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

// class AppChatTheme {
//   static ChatTheme light = ChatTheme(
//     colors: ChatColors(
//       primary: Color(0xFFCCE5FF), // رنگ حباب پیام‌های خود کاربر
//       onPrimary: Colors.black, // رنگ متن داخل حباب پیام خود کاربر
//       surface: Colors.white, // پس‌زمینه عمومی
//       onSurface: Colors.black87, // رنگ متن‌های عمومی
//       surfaceContainer: Color(0xFFF0F0F0), // حباب پیام طرف مقابل
//       surfaceContainerLow: Color(0xFFF9F9F9), // حباب‌ها یا ورودی‌ها
//       surfaceContainerHigh: Color(0xFFE0E0E0), // تمایز حباب‌ها
//     ),
//     typography: ChatTypography(
//       bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//       bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
//       bodySmall: TextStyle(fontSize: 12, color: Colors.black54),
//       labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//       labelMedium: TextStyle(fontSize: 12),
//       labelSmall: TextStyle(fontSize: 10, color: Colors.grey),
//     ),
//     shape: BorderRadius.circular(16),
//   );
// }
