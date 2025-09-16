import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/enums/filter_shortby_enum.dart';

extension FilterShortbyExtension on FilterShortByEnum {
  IconData get getIcon {
    switch (this) {
      case FilterShortByEnum.relevancy:
        return Icons.sort;
      case FilterShortByEnum.popularity:
        return Icons.trending_up;
      case FilterShortByEnum.publishedAt:
        return Icons.calendar_today;
    }
  }
}
