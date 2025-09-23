import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

@immutable
final class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({required this.child, super.key});

  final Widget child;

  static final tabs = [
    RoutePaths.home.path,
    RoutePaths.explore.path,
    RoutePaths.bookmark.path,
    RoutePaths.profile.path,
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    var currentIndex = tabs.indexWhere(location.startsWith);
    if (currentIndex == -1) currentIndex = 0;

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          router.go(tabs[index]);
        },
        items: [
          BottomNavigationBarItem(
            icon: _BehindContainer(
              isCurrentIndex: currentIndex == 0,
              selectedIcon: Icons.home,
              unSelectedIcon: Icons.home_outlined,
            ),
            label: LocaleKeys.home.tr(),
          ),
          BottomNavigationBarItem(
            icon: _BehindContainer(
              isCurrentIndex: currentIndex == 1,
              selectedIcon: Icons.explore_rounded,
              unSelectedIcon: Icons.explore_outlined,
            ),
            label: LocaleKeys.explore.tr(),
          ),
          BottomNavigationBarItem(
            icon: _BehindContainer(
              isCurrentIndex: currentIndex == 2,
              selectedIcon: Icons.bookmark_rounded,
              unSelectedIcon: Icons.bookmark_border_outlined,
            ),
            label: LocaleKeys.bookmarks.tr(),
          ),
          BottomNavigationBarItem(
            icon: _BehindContainer(
              isCurrentIndex: currentIndex == 3,
              selectedIcon: Icons.person_2_rounded,
              unSelectedIcon: Icons.person_2_outlined,
            ),
            label: LocaleKeys.profile.tr(),
          ),
        ],
      ),
    );
  }
}

class _BehindContainer extends StatelessWidget {
  const _BehindContainer({
    required this.isCurrentIndex,
    required this.selectedIcon,
    required this.unSelectedIcon,
  });

  final bool isCurrentIndex;
  final IconData selectedIcon;
  final IconData unSelectedIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isCurrentIndex
            ? AppTheme.primaryColor.withValues(alpha: 0.1)
            : null,
      ),
      child: Icon(isCurrentIndex ? selectedIcon : unSelectedIcon),
    );
  }
}
