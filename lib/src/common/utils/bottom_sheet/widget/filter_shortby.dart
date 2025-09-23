import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/widget/filter_chip.dart';
import 'package:newsapp/src/common/utils/enums/filter_shortby_enum.dart';
import 'package:newsapp/src/common/utils/extensions/filter_shortby_extension.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

@immutable
final class FilterShortby extends StatefulWidget {
  const FilterShortby({required this.shortBy, super.key});
  final List<FilterShortByEnum> shortBy;

  @override
  State<FilterShortby> createState() => _FilterShortbyState();
}

class _FilterShortbyState extends State<FilterShortby> {
  bool isShortByItemSelected(FilterShortByEnum item) {
    return widget.shortBy.contains(item);
  }

  List<FilterShortByEnum> get newShortBy => widget.shortBy;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...FilterShortByEnum.values.map((item) {
          return FilterChipItem(
            avatar: Icon(
              item.getIcon,
              color: isShortByItemSelected(item)
                  ? AppTheme.buttonBackground
                  : AppTheme.backgroundDark,
            ),
            label: item.name,
            isSelected: isShortByItemSelected(item),
            onSelected: (value) {
              final result = isShortByItemSelected(item);
              if (result) {
                newShortBy.clear();
              } else {
                if (newShortBy.length == 1) {
                  newShortBy.clear();
                }
                newShortBy.add(item);
              }
              setState(() {});
              return null;
            },
          );
        }),
      ],
    );
  }
}
