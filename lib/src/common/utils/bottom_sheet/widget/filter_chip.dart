import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';

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
        showCheckmark: false,
        label: LuciText.bodySmall(label.capitalizeFirst),
        onSelected: onSelected.call,
      ),
    );
  }
}
