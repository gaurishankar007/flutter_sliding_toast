import 'package:flutter/material.dart';

/// The toast will start sliding from this direction
enum ToastPosition {
  top,
  right,
  bottom,
  left;

  /// Tween with start and end offsets based on the toast start position
  Tween<Offset> tween() {
    switch (this) {
      case ToastPosition.top:
        return Tween(
          begin: const Offset(0, -1),
          end: const Offset(0, 0),
        );
      case ToastPosition.right:
        return Tween(
          begin: const Offset(1, 0),
          end: const Offset(0, 0),
        );
      case ToastPosition.bottom:
        return Tween(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        );
      case ToastPosition.left:
        return Tween(
          begin: const Offset(-1, 0),
          end: const Offset(0, 0),
        );
    }
  }

  /// Dismiss direction according to the toast start position
  DismissDirection dismissDirection() {
    switch (this) {
      case ToastPosition.top:
        return DismissDirection.up;
      case ToastPosition.right:
        return DismissDirection.horizontal;
      case ToastPosition.bottom:
        return DismissDirection.down;
      case ToastPosition.left:
        return DismissDirection.horizontal;
    }
  }
}
