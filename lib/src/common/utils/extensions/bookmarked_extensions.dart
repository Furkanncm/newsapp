import 'package:newsapp/src/common/utils/enums/bookmark_state.dart';

extension BookmarkExtension on BookmarkState {
  bool? toBool() {
    switch (this) {
      case BookmarkState.bookmarked:
        return true;
      case BookmarkState.notBookmarked:
        return false;
      case BookmarkState.nothingChanged:
        return null;
    }
  }
}