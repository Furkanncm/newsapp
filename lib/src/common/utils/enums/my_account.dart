import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart' as key;
import 'package:flutter/material.dart';

enum MyAccountEnum {
  darkMode(label: LocaleKeys.darkMode, icon: Icons.dark_mode_outlined),
  security(label: LocaleKeys.security, icon: Icons.security_outlined),
  help(label: LocaleKeys.helpAndSupport, icon: Icons.help_outline_outlined),

  logOut(label: LocaleKeys.logOut, icon: Icons.logout);

  const MyAccountEnum({required this.label, this.icon});
  final IconData? icon;
  final String label;
   String get title => label.tr();
}
