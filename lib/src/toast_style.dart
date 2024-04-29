import 'package:flutter/material.dart';

/// A style for the toast container.
@immutable
class ToastStyle {
  /// The background color of the toast.
  /// Default is [Colors.white]
  final Color backgroundColor;

  /// The shadow of the toast.
  /// Default is a shadow with 5 blur radius, 3 spread radius, and 2 offset.
  final BoxShadow boxShadow;

  /// The border radius of the toast.
  /// Default is [BorderRadius.circular(8)]
  final BorderRadius borderRadius;

  /// The border of the toast.
  /// Default is [null]
  final Border? border;

  /// The color of the progress bar.
  /// Default is [Theme.of(context).primaryColor]
  final Color? progressBarColor;

  const ToastStyle({
    this.backgroundColor = Colors.white,
    this.boxShadow = const BoxShadow(
      // First two hexadecimal digits in the color refer to the opacity
      color: Color(0x10000000),
      blurRadius: 5,
      spreadRadius: 3,
      offset: Offset(2, 2),
    ),
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.border,
    this.progressBarColor,
  });

  ToastStyle copyWith({
    Color? backgroundColor,
    BoxShadow? boxShadow,
    BorderRadius? borderRadius,
    Border? border,
    Color? progressBarColor,
  }) {
    return ToastStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      boxShadow: boxShadow ?? this.boxShadow,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      progressBarColor: progressBarColor ?? this.progressBarColor,
    );
  }
}
