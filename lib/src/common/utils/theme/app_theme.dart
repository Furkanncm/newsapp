import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Ana renkler
  static const Color primaryColor = ColorName.primaryColor; // #2ECC71 - Soft Green
  static const Color primaryVariant = ColorName.primaryVariant; // #27AE60 - Deep Green
  static const Color secondaryColor = ColorName.secondaryColor; // #A3E4D7 - Mint Green
  static const Color secondaryVariant = ColorName.secondaryVariant; // #1ABC9C - Turquoise
  static const Color backgroundLight = ColorName.backgroundLight; // #F0FDF4
  static const Color backgroundDark = ColorName.backgroundDark; // #1E2D24
  static const Color surfaceColor = ColorName.surfaceColor; // #FFFFFF
  static const Color surfaceDarkColor = Color.fromARGB(255, 116, 126, 137); // #2C3E50
  static const Color textColorLight = ColorName.textColorLight; // #1E2D24
  static const Color textColorDark = ColorName.textColorDark; // #ECF0F1
  static const Color errorColor = ColorName.errorColor; // #E74C3C
  static const Color accentColor = ColorName.accentColor; //  #F1C40F

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: backgroundLight,
      error: errorColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: textColorLight,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      suffixIconColor: primaryVariant,
      labelStyle: const TextStyle(color: Colors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: const WidgetStatePropertyAll(backgroundLight),
      checkColor: const WidgetStatePropertyAll(backgroundDark),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentColor,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    iconTheme: const IconThemeData(
      size: 24,
      color: primaryVariant,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundDark,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: primaryColor,
      secondary: secondaryVariant,
      surface: backgroundDark,
      error: errorColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: textColorDark,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: textColorDark),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColorDark),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceDarkColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryVariant,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: const WidgetStatePropertyAll(backgroundLight),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: secondaryColor,
      ),
    ),
  );
}
