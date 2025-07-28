import 'package:flutter/material.dart';
import 'package:lucielle/widget/text/luci_text.dart';

class NewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NewsAppBar({
    required this.title,
    this.actions,
    super.key,
    this.centerTitle = true,
  });

  final String title;
  final bool centerTitle;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: LuciText.labelMedium(title, fontWeight: FontWeight.bold),
      centerTitle: centerTitle,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
