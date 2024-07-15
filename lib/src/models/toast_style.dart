import 'package:flutter/material.dart';

/// A style for the toast container.
@immutable
class ToastStyle {
  /// Padding inside the toast
  final EdgeInsets? padding;

  /// Space between title and leading
  /// Applicable only if both available
  final double titleLeadingGap;

  /// Space between title and trailing
  /// Applicable only if both available
  final double titleTrailingGap;

  /// The background color of the toast.
  /// Default is [Colors.white]
  final Color backgroundColor;

  /// The amount of blur for glassier effect.
  /// A [backgroundColorOpacity] of 80% is given
  /// only if not given explicitly.
  final double? glassBlur;

  /// The opacity used for background color.
  /// Default [backgroundColorOpacity] is 80%.
  final double? backgroundColorOpacity;

  /// The shadow of the toast.
  /// Default is a shadow with 5 blur radius,
  /// 3 spread radius, and 2 offset.
  final List<BoxShadow>? boxShadow;

  /// The border radius of the toast.
  /// Default is [BorderRadius.circular(8)]
  final BorderRadius borderRadius;

  /// The border of the toast.
  /// Default is [null]
  final Border? border;

  /// The color of the progress bar.
  /// Default is [Theme.of(context).primaryColor]
  final Color? progressBarColor;

  /// The width of the title widget expanding to the available width
  /// Default is [true]
  /// * If progress bar is enabled, then title will be always expanded
  final bool expandedTitle;

  const ToastStyle({
    this.padding,
    this.titleLeadingGap = 5,
    this.titleTrailingGap = 5,
    this.glassBlur,
    this.backgroundColorOpacity,
    this.backgroundColor = Colors.white,
    this.boxShadow = const [
      BoxShadow(
        // First two hexadecimal digits in the color refer to the opacity
        color: Color(0x10000000),
        blurRadius: 5,
        spreadRadius: 3,
        offset: Offset(2, 2),
      )
    ],
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.border,
    this.progressBarColor,
    this.expandedTitle = true,
  });

  ToastStyle copyWith({
    EdgeInsets? padding,
    double? titleLeadingGap,
    double? titleTrailingGap,
    Color? backgroundColor,
    double? glassBlur,
    double? backgroundColorOpacity,
    List<BoxShadow>? boxShadow,
    BorderRadius? borderRadius,
    Border? border,
    Color? progressBarColor,
    bool? expandedTitle,
  }) {
    return ToastStyle(
      padding: padding ?? this.padding,
      titleLeadingGap: titleLeadingGap ?? this.titleLeadingGap,
      titleTrailingGap: titleTrailingGap ?? this.titleTrailingGap,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      glassBlur: glassBlur ?? this.glassBlur,
      backgroundColorOpacity:
          backgroundColorOpacity ?? this.backgroundColorOpacity,
      boxShadow: boxShadow ?? this.boxShadow,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      progressBarColor: progressBarColor ?? this.progressBarColor,
      expandedTitle: expandedTitle ?? this.expandedTitle,
    );
  }
}
