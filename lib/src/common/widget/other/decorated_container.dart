import 'package:flutter/material.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';

@immutable
final class DecoratedContainer extends StatelessWidget {
  const DecoratedContainer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: NaPadding.mainButtonPadding / 2,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
