import 'package:flutter/widgets.dart';

/// The setting for the dialog shown when a toast is tapped,
/// which displays the whole toast content, scrollable if too long.
@immutable
class ToastDialogSetting {
  const ToastDialogSetting({
    this.maxWidth,
    this.maxHeight,
    this.padding = const EdgeInsets.all(16),
    this.barrierColor = const Color(0xCC000000),
    this.barrierDismissible = true,
    this.animationDuration = const Duration(milliseconds: 250),
  });

  /// The maximum width of the dialog
  /// Default is the toast's max width, or [80% of the screen width]
  final double? maxWidth;

  /// The maximum height of the dialog
  /// Default is [60% of the screen height]
  final double? maxHeight;

  /// The space between the dialog and the screen edges.
  /// Default is [EdgeInsets.all(16)]
  final EdgeInsets padding;

  /// The color of the barrier behind the dialog.
  /// Default is black with 80% opacity
  final Color barrierColor;

  /// Whether tapping the barrier closes the dialog.
  /// Default is true
  final bool barrierDismissible;

  /// How long the dialog takes to fade and scale in and out.
  /// Default is [Duration(milliseconds: 250)]
  final Duration animationDuration;

  ToastDialogSetting copyWith({
    double? maxWidth,
    double? maxHeight,
    EdgeInsets? padding,
    Color? barrierColor,
    bool? barrierDismissible,
    Duration? animationDuration,
  }) {
    return ToastDialogSetting(
      maxWidth: maxWidth ?? this.maxWidth,
      maxHeight: maxHeight ?? this.maxHeight,
      padding: padding ?? this.padding,
      barrierColor: barrierColor ?? this.barrierColor,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }
}
