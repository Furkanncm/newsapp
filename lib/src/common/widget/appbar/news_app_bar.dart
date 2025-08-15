import 'package:flutter/material.dart';
import 'package:lucielle/widget/text/luci_text.dart';

class NewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NewsAppBar({
    required this.title,
    this.actions,
    super.key,
    this.centerTitle = true,
    this.bottom,
  });

  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final TabBar? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: LuciText.labelMedium(title, fontWeight: FontWeight.bold),
      centerTitle: centerTitle,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize {
    if (bottom != null) {
      return Size.fromHeight(kToolbarHeight + bottom!.preferredSize.height);
    }
    return const Size.fromHeight(kToolbarHeight);
  }
}
