import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/data/enums/route_paths.dart';

mixin CongratulationsMixin on StatelessWidget {
  void routeHomePage() => router.goNamed(RoutePaths.chooseCountry.name);
}
