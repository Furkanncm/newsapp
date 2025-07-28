import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucielle/utils/extensions/extensions.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/data/enums/route_paths.dart';

class AppNavigationBar extends StatelessWidget {
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
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.bodyText,
        showUnselectedLabels: true,
        currentIndex: currentIndex,
        onTap: (index) {
          if (index != currentIndex) {
            router.go(tabs[index]);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 0 ? Icons.home_rounded : Icons.home_outlined,
            ),
            label: RoutePaths.home.name.capitalizeFirst,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 1
                  ? Icons.explore_rounded
                  : Icons.explore_outlined,
            ),
            label: RoutePaths.explore.name.capitalizeFirst,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 2
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_border_outlined,
            ),
            label: RoutePaths.bookmark.name.capitalizeFirst,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 3
                  ? Icons.person_2_rounded
                  : Icons.person_2_outlined,
            ),
            label: RoutePaths.profile.name.capitalizeFirst,
          ),
        ],
      ),
    );
  }
}
