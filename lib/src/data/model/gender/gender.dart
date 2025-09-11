import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/enums/gender_enum.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

final class Gender extends Equatable {
  const Gender({required this.label, required this.icon});

  final String label;
  final Icon icon;

  @override
  List<Object?> get props => [label, icon];
  static List<Gender> getGenders() {
    return [
      Gender(
        label: GenderEnum.male.value,
        icon: const Icon(Icons.male, color: AppTheme.primaryColor),
      ),
      Gender(
        label: GenderEnum.female.value,
        icon: const Icon(Icons.female, color: AppTheme.errorColor),
      ),
      Gender(
        label: GenderEnum.other.value,
        icon: const Icon(Icons.transgender, color: AppTheme.warningColor),
      ),
    ];
  }
}
