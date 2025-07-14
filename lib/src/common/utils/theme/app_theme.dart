import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Renk tanımları
  static const Color primaryColor = ColorName.primaryColor; // #0071F2
  static const Color errorColor = ColorName.errorColor; // #ED2E7E
  static const Color successColor = ColorName.successColor; // #00C28B
  static const Color warningColor = ColorName.warningColor; // #F5B73F
  static const Color titleActive = ColorName.titleActive; // #1C1C1C
  static const Color bodyText = ColorName.bodyText; // #444444
  static const Color buttonText = ColorName.buttonText; // #6C7386
  static const Color placeholder = ColorName.placeholder; // #979DB8
  static const Color buttonBackground = ColorName.buttonBackground; // #F2F3F6
  static const Color disabledInput = ColorName.disabledInput; // #F2F3F6
  static const Color accentColor = ColorName.accentColor; // #F1C40F

  static const Color backgroundDark = ColorName.backgroundDark; // #1C1C1C
  static const Color inputDark = ColorName.inputDark; // #2E2E2E
  static const Color bodyDark = ColorName.bodyDark; // #C4C4C4
  static const Color titleDark = ColorName.titleDark; // #F2F3F6

  static const Color surfaceColor = Colors.white;

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: buttonBackground,
    colorScheme: const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: successColor,
      surface: buttonBackground,
      error: errorColor,
    ),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: buttonBackground,
      elevation: 0,
      foregroundColor: titleActive,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      suffixIconColor: primaryColor,
      labelStyle: const TextStyle(color: bodyText),
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
      fillColor: const WidgetStatePropertyAll(buttonBackground),
      checkColor: const WidgetStatePropertyAll(backgroundDark),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: buttonText,
      ),
    ),
    iconTheme: const IconThemeData(
      size: 24,
      color: primaryColor,
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundDark,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: primaryColor,
      secondary: successColor,
      surface: inputDark,
      error: errorColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: titleDark,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: bodyDark),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: titleDark),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: inputDark,
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: const WidgetStatePropertyAll(titleDark),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: successColor,
      ),
    ),
  );
}
