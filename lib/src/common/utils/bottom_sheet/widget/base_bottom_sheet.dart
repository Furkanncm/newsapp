import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';

@immutable
final class BaseBottomSheet extends StatelessWidget {
  const BaseBottomSheet({
    required this.title,
    required this.child,
    super.key,
    this.onPressed,
  });

  final String title;
  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: NaPadding.pagePadding,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalBox8,
              Divider(
                thickness: 4,
                indent: context.width * 0.4,
                endIndent: context.width * 0.4,
                radius: BorderRadius.circular(16),
              ),
              verticalBox16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LuciText.labelLarge(title),
                  IconButton(
                    onPressed: onPressed?.call,
                    icon: const Icon(Icons.check_outlined),
                  ),
                ],
              ),
              const Divider(),
              verticalBox8,
              child,
              verticalBox16,
            ],
          ),
        ),
      ),
    );
  }
}
