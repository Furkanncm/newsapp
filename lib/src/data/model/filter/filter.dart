import 'package:codegen/codegen.dart';
import 'package:newsapp/src/common/utils/enums/filter_shortby_enum.dart';

class Filter {
  Filter({required this.shortBy, required this.language});

  final List<FilterShortByEnum> shortBy;
  final List<Country> language;
}
