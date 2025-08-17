import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/widget/other/no_network_container.dart';

@immutable
final class AppBuilder extends StatelessWidget {
  const AppBuilder({required this.child, super.key});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        child ?? emptyBox,
        const Positioned(bottom: 0, child: NoNetworkContainer()),
      ],
    );
  }
}
