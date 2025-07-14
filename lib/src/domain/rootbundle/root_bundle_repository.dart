import 'dart:convert';

import 'package:codegen/model/country_model/country_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:newsapp/src/common/utils/extensions/root_bunlde_extension.dart';
import 'package:newsapp/src/data/enums/root_bundle.dart';

abstract class IRootBundleManager {
  Future<List<Country>> loadCountries(RootBundle bundle);
}

class RootBundleManager implements IRootBundleManager {
  @override
  Future<List<Country>> loadCountries(RootBundle bundle) async {
    final jsonStr = await rootBundle.loadString(bundle.name.toJson);
    return compute(parseCountries, jsonStr);
  }

  List<Country> parseCountries(String jsonStr) {
    final data = json.decode(jsonStr) as List<dynamic>;
    return data.map((e) => Country.fromJson(e as Map<String, dynamic>)).toList();
  }
}
