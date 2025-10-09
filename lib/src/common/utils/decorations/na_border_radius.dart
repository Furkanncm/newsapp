import 'package:flutter/material.dart';

/// A utility class that defines consistent and reusable border radii
/// for UI components across the app.
///
/// This class extends [BorderRadius] and provides predefined named
/// constructors for small, medium, large, and extra-large rounded corners.
///
/// ### Example usage:
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     color: Colors.blue,
///     borderRadius: const NaBorderRadius.mediumRadius(),
///   ),
/// )
/// ```
///
/// Using this class helps maintain design consistency by keeping
/// corner radius values centralized.
final class NaBorderRadius extends BorderRadius {
  /// Creates a [BorderRadius] with medium circular radius on all corners.
  ///
  /// Equivalent to `BorderRadius.all(Radius.circular(8.0))`.
  const NaBorderRadius.all() : super.all(const Radius.circular(_medium));

  /// Creates a [BorderRadius] with a small corner radius.
  ///
  /// Equivalent to `BorderRadius.circular(4.0)`.
  NaBorderRadius.smallRadius() : super.circular(_small);

  /// Creates a [BorderRadius] with a medium corner radius.
  ///
  /// Equivalent to `BorderRadius.circular(8.0)`.
  NaBorderRadius.mediumRadius() : super.circular(_medium);

  /// Creates a [BorderRadius] with a large corner radius.
  ///
  /// Equivalent to `BorderRadius.circular(12.0)`.
  NaBorderRadius.largeRadius() : super.circular(_large);

  /// Creates a [BorderRadius] with an extra-large corner radius.
  ///
  /// Equivalent to `BorderRadius.circular(16.0)`.
  NaBorderRadius.extraLargeRadius() : super.circular(_extraLarge);

  /// Small radius value (4.0).
  static const _small = 4.0;

  /// Medium radius value (8.0).
  static const _medium = 8.0;

  /// Large radius value (12.0).
  static const _large = 12.0;

  /// Extra large radius value (16.0).
  static const _extraLarge = 16.0;
}
