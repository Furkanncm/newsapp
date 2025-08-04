import 'package:flutter/material.dart';
import 'package:lucielle/widget/sized_box/space_box.dart';
import 'package:newsapp/src/common/widget/other/no_network_container.dart';

class BuilderWidget extends StatelessWidget {
  const BuilderWidget({required this.child, super.key});

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
