import 'package:flutter/material.dart';
import 'package:lucielle/widget/text/luci_text.dart';
import 'package:newsapp/src/common/utils/router/router.dart';

class NewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NewsAppBar({
    this.title,
    this.actions,
    super.key,
    this.centerTitle = true,
    this.bottom,
  });

  final String? title;
  final bool centerTitle;
  final List<Widget>? actions;
  final TabBar? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: router.pop,
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
      ),
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
