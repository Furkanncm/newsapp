import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/router/router.dart';

mixin CongratulationsMixin on StatelessWidget {
  void routeHomePage() => router.goNamed(RoutePaths.login.name);
}
