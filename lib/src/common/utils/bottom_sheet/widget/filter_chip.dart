import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';


@immutable
final class FilterChipItem extends StatelessWidget {
  const FilterChipItem({
    required this.avatar,
    required this.label,
    required this.isSelected,
    required this.onSelected,
    super.key,
  });

  final Widget avatar;
  final String label;
  final bool isSelected;
  final String? Function(bool value) onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        avatar: avatar,
        disabledColor: Colors.red,
        showCheckmark: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
          side: const BorderSide(color: AppTheme.backgroundDark),
        ),
        backgroundColor: WidgetStateColor.resolveWith((states) => AppTheme.disabledInput),
        selectedShadowColor: Colors.transparent,
        selectedColor: WidgetStateColor.resolveWith((states) => AppTheme.primaryColor),
        label: LuciText.bodySmall(
          label.capitalizeFirst,
          textColor: isSelected ? AppTheme.disabledInput : AppTheme.bodyText,
        ),
        onSelected: onSelected.call,
      ),
    );
  }
}
