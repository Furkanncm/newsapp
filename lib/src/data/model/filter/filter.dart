
import 'package:codegen/codegen.dart';
import 'package:codegen/model/topic/topic.dart';

import 'package:newsapp/src/common/utils/enums/filter_shortby_enum.dart';

class Filter {
  Filter({
     this.shortBy,
     this.language,
     this.topic,
  });

  final List<FilterShortByEnum>? shortBy;
  final List<Country> ?language;
  final List<Topic> ?topic;
}
