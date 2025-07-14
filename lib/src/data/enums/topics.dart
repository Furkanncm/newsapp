import 'package:flutter/material.dart';

enum Topic {
  business('Business', Icons.business_center_outlined),
  entertainment('Entertainment', Icons.movie_filter_outlined),
  general('General', Icons.public),
  health('Health', Icons.health_and_safety_outlined),
  science('Science',Icons.science_outlined),
  sports('Sports', Icons.sports_soccer_outlined),
  technology('Technology', Icons.memory_outlined);

  const Topic(this.value, this.icon);
  final String value;
  final IconData icon;
}
