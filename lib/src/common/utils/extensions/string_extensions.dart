extension StringExtensions on String {
  String get setPastTime {
    final difference = DateTime.now().difference(DateTime.parse(this));
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  String limitString({int limit = 7}) {
    if (length <= limit) return this;
    return '${substring(0, limit)}...';
  }
}
