import 'package:flutter/material.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.darkBlue,
    scaffoldBackgroundColor: AppColors.lightBlueBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBlue,
      foregroundColor: AppColors.white,
      elevation: 2,
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: IconThemeData(color: AppColors.darkBlue),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.softBlue, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.softBlue, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.darkBlue, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.softBlue),
      ),
      hintStyle: const TextStyle(
        color: AppColors.darkGrey,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      labelStyle: const TextStyle(
        color: AppColors.darkGrey,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      errorStyle: const TextStyle(
        color: Colors.redAccent,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      errorMaxLines: 2,
      prefixIconColor: AppColors.darkGrey,
      suffixIconColor: AppColors.darkGrey,
      floatingLabelStyle: const TextStyle(
        color: AppColors.darkBlue,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: AppColors.black,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: AppColors.black,
        fontSize: 28,
        fontWeight: FontWeight.w500,
      ),
      displaySmall: TextStyle(
        color: AppColors.black,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: TextStyle(
        color: AppColors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: AppColors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: AppColors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(color: AppColors.black, fontSize: 12),
      labelLarge: TextStyle(
        color: AppColors.mediumBlue,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: TextStyle(color: AppColors.darkGrey, fontSize: 11),
    ),
    dividerColor: AppColors.softBlue,
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.mediumBlue,
      inactiveTrackColor: AppColors.softBlue,
      thumbColor: AppColors.mediumBlue,
      overlayColor: AppColors.mediumBlue,
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.darkBlue,
      secondary: AppColors.softBlue,
      surface: AppColors.white,
      onPrimary: AppColors.white,
      onSecondary: AppColors.black,
      onSurface: AppColors.black,
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.softBlue,
    scaffoldBackgroundColor: AppColors.darkBlue,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.mediumBlue,
      foregroundColor: AppColors.white,
      elevation: 2,
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: IconThemeData(color: AppColors.white),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.mediumBlue,
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.softBlue),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.softBlue),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.white, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.redAccent, width: 2),
      ),
      hintStyle: TextStyle(color: AppColors.white),
      labelStyle: TextStyle(color: AppColors.white),
      errorStyle: TextStyle(color: Colors.redAccent),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: AppColors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: AppColors.white,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: TextStyle(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: TextStyle(
        color: AppColors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: AppColors.white, fontSize: 14),
      bodyMedium: TextStyle(color: AppColors.white, fontSize: 12),
      labelLarge: TextStyle(
        color: AppColors.softBlue,
        fontWeight: FontWeight.w600,
      ),
    ),
    dividerColor: AppColors.softBlue,
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.softBlue,
      inactiveTrackColor: AppColors.mediumBlue,
      thumbColor: AppColors.white,
      overlayColor: AppColors.white,
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.softBlue,
      secondary: AppColors.mediumBlue,
      surface: AppColors.mediumBlue,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.white,
    ),
  );
}
