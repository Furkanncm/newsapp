import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/decorations/na_border_radius.dart';
import 'package:newsapp/src/common/utils/decorations/na_outline_input_border.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';

class AppTheme extends LuciTheme {
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
      hintStyle: const TextStyle(color: placeholder),
      labelStyle: const TextStyle(color: bodyText),
      errorStyle: const TextStyle(color: errorColor, fontSize: 12),
      enabledBorder: NaOutlineInputBorder.noneBorder(),
      focusedBorder: NaOutlineInputBorder.noneBorder(),
      errorBorder: NaOutlineInputBorder.noneBorder(),
      focusedErrorBorder: NaOutlineInputBorder.noneBorder(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: buttonBackground,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: NaBorderRadius.largeRadius(),
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: const WidgetStatePropertyAll(buttonBackground),
      checkColor: const WidgetStatePropertyAll(backgroundDark),
      shape: RoundedRectangleBorder(
        borderRadius: NaBorderRadius.mediumRadius(),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: buttonText),
    ),
    iconTheme: const IconThemeData(size: 24, color: buttonText),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      unselectedItemColor: bodyDark,
      showUnselectedLabels: true,
    ),
    cardTheme: const CardThemeData(
      color: surfaceColor,
      shadowColor: Colors.black26,
      elevation: 4,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return primaryColor;
        return placeholder;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryColor.withValues(alpha: 0.5);
        }
        return placeholder.withValues(alpha: 0.3);
      }),
    ),
    dividerTheme: const DividerThemeData(thickness: 1, color: placeholder),
    expansionTileTheme: const ExpansionTileThemeData(
      tilePadding: EdgeInsets.symmetric(horizontal: 16),
      collapsedBackgroundColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      childrenPadding: NaPadding.pagePadding,
      iconColor: bodyDark,
      collapsedIconColor: backgroundDark,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: buttonBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    ),
    chipTheme: ChipThemeData(
      labelStyle: const TextStyle(color: bodyText),
      secondaryLabelStyle: const TextStyle(color: Colors.white),
      backgroundColor: buttonBackground,
      selectedColor: primaryColor,
      secondarySelectedColor: primaryColor,
      disabledColor: disabledInput,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: NaBorderRadius.mediumRadius(),
        side: const BorderSide(color: placeholder),
      ),
      checkmarkColor: Colors.white,
      shadowColor: Colors.transparent,
      selectedShadowColor: Colors.transparent,
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
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: inputDark,
      hintStyle: const TextStyle(color: bodyDark),
      labelStyle: const TextStyle(color: titleDark),
      errorStyle: const TextStyle(color: errorColor, fontSize: 12),
      enabledBorder: NaOutlineInputBorder.noneBorder(),
      focusedBorder: NaOutlineInputBorder.noneBorder(),
      errorBorder: NaOutlineInputBorder.noneBorder(),
      focusedErrorBorder: NaOutlineInputBorder.noneBorder(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: NaBorderRadius.largeRadius(),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: const WidgetStatePropertyAll(titleDark),
      shape: RoundedRectangleBorder(
        borderRadius: NaBorderRadius.mediumRadius(),
      ),
    ),

    iconTheme: const IconThemeData(size: 24, color: primaryColor),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      unselectedItemColor: bodyDark,
      showUnselectedLabels: true,
    ),
    cardTheme: const CardThemeData(
      color: inputDark,
      shadowColor: backgroundDark,
      elevation: 4,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return primaryColor;
        return titleDark;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryColor.withValues(alpha: 0.5);
        }
        return titleDark.withValues(alpha: 0.3);
      }),
    ),
    dividerTheme: const DividerThemeData(thickness: 1, color: placeholder),
    expansionTileTheme: const ExpansionTileThemeData(
      tilePadding: EdgeInsets.symmetric(horizontal: 16),
      collapsedBackgroundColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      childrenPadding: NaPadding.pagePadding,
      iconColor: bodyDark,
      collapsedIconColor: titleDark,
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: backgroundDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    ),
    chipTheme: ChipThemeData(
      labelStyle: const TextStyle(color: titleDark),
      secondaryLabelStyle: const TextStyle(color: surfaceColor),
      backgroundColor: inputDark,
      selectedColor: primaryColor,
      secondarySelectedColor: primaryColor,
      disabledColor: backgroundDark,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: NaBorderRadius.mediumRadius(),
        side: const BorderSide(color: bodyDark),
      ),
      checkmarkColor: surfaceColor,
      shadowColor: Colors.transparent,
      selectedShadowColor: Colors.transparent,
    ),
  );

  @override
  ThemeData get luciThemeData => lightTheme;
}
