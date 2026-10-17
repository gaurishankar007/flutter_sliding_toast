import 'package:flutter/widgets.dart';

/// The toast will start sliding from this direction
enum ToastPosition {
  top,
  right,
  bottom,
  left;

  /// Tween with start and end offsets based on the toast start position
  Tween<Offset> tween() => switch (this) {
    .top => Tween(begin: const Offset(0, -1), end: Offset.zero),
    .right => Tween(begin: const Offset(1, 0), end: Offset.zero),
    .bottom => Tween(begin: const Offset(0, 1), end: Offset.zero),
    .left => Tween(begin: const Offset(-1, 0), end: Offset.zero),
  };

  /// Dismiss direction according to the toast start position
  DismissDirection dismissDirection() => switch (this) {
    .top => .up,
    .bottom => .down,
    .left || .right => .horizontal,
  };
}
