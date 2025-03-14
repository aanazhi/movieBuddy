import 'package:flutter/material.dart';

@immutable
class AppTheme {
  const AppTheme._();

  static final dark = ThemeData(
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Aldrich',
        fontWeight: FontWeight.w400,
        fontSize: 40,
        color: AppColors.whiteColor,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Aldrich',
        fontWeight: FontWeight.w400,
        fontSize: 25,
        color: AppColors.whiteColor,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Aldrich',
        fontWeight: FontWeight.w400,
        fontSize: 20,
        color: AppColors.whiteColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Aldrich',
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: AppColors.whiteColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Aldrich',
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: AppColors.whiteColor,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Aldrich',
        fontWeight: FontWeight.w400,
        fontSize: 15,
        color: AppColors.whiteColor,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Aldrich',
        fontWeight: FontWeight.w400,
        fontSize: 20,
        color: AppColors.whiteColor,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.whiteColor,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Aldrich',
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: AppColors.backgroundColor,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.activeTrackColor,
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.backgroundColor,
      secondary: AppColors.whiteColor,
      error: AppColors.colorLightRed,
      onPrimary: AppColors.inactiveTrackColor,
      surface: AppColors.activeTrackColor,
      shadow: AppColors.colorWithOpacity,
      surfaceBright: AppColors.transparent,
      tertiaryFixed: AppColors.colorOpasity5,
      onTertiaryFixed: AppColors.colorOpasity8,
    ),
  );
}

class AppColors {
  static const Color backgroundColor = Color.fromRGBO(34, 34, 34, 1);
  static const Color whiteColor = Color.fromRGBO(207, 220, 253, 1);
  static const Color activeTrackColor = Color.fromRGBO(74, 125, 255, 1);
  static const Color inactiveTrackColor = Color.fromRGBO(50, 50, 50, 1);
  static const Color colorLightRed = Color.fromRGBO(192, 63, 63, 1);
  static Color colorWithOpacity = Colors.white.withOpacity(0.1);
  static const Color transparent = Colors.transparent;
  static const Color colorOpasity5 = Color.fromRGBO(34, 34, 34, 0.5);
  static const Color colorOpasity8 = Color.fromRGBO(34, 34, 34, 0.8);
}
