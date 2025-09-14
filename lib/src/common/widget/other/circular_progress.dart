import 'package:flutter/material.dart';

class AdaptiveCircular extends StatelessWidget {
  const AdaptiveCircular({super.key}) : expanded = true;

  const AdaptiveCircular.withoutExpanded({super.key}) : expanded = false;

  final bool expanded;

  @override
  Widget build(BuildContext context) {
    const widget = Center(child: CircularProgressIndicator.adaptive());
    if (expanded) {
      return const Expanded(child: widget);
    }
    return widget;
  }
}
