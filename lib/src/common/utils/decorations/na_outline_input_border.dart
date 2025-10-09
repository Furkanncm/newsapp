import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/decorations/na_border_radius.dart';

/// A custom implementation of [OutlineInputBorder] that provides
/// predefined and consistent border styles for text fields and input widgets.
///
/// The `NaOutlineInputBorder` class helps maintain design consistency
/// throughout the app by centralizing commonly used border configurations.
///
/// Currently, it defines a [noneBorder] variant with:
/// - A large rounded corner radius (from [NaBorderRadius.largeRadius])
/// - No visible border line (`BorderSide.none`)
///
/// ### Example usage:
/// ```dart
/// TextFormField(
///   decoration: InputDecoration(
///     border: NaOutlineInputBorder.noneBorder(),
///     filled: true,
///     fillColor: Colors.grey.shade200,
///   ),
/// )
/// ```
final class NaOutlineInputBorder extends OutlineInputBorder {
  /// Creates an input border with **no visible border line** and
  /// a **large corner radius** for a modern, clean UI style.
  ///
  /// Equivalent to:
  /// ```dart
  /// OutlineInputBorder(
  ///   borderRadius: BorderRadius.circular(12.0),
  ///   borderSide: BorderSide.none,
  /// )
  /// ```
  NaOutlineInputBorder.noneBorder()
    : super(
        borderRadius: NaBorderRadius.largeRadius(),
        borderSide: BorderSide.none,
      );
}
