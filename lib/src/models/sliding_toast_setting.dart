import 'package:flutter/material.dart';

import '../enums/toast_position.dart';

/// The setting for the sliding animation
@immutable
class SlidingToastSetting {
  /// The maximum width of the toast
  /// Default is [80% of the screen width]
  final double? maxWidth;

  /// The maximum height of the toast
  /// Default is [40% of the screen height]
  final double? maxHeight;

  /// The sliding behavior of the animation.
  /// Default is [Curves.elasticOut]
  final Curve curve;

  /// How long the toast will slide.
  /// Default is [Duration(seconds: 1)]
  final Duration animationDuration;

  /// How long the toast will be displayed
  /// after the completion of the animation.
  /// Default is [Duration(seconds: 1)]
  final Duration displayDuration;

  /// Whether to show the reverse animation or not to dismiss the toast.
  /// Default is [true]
  final bool showReverseAnimation;

  /// The height of the progress bar.
  /// Default is [3]
  /// ProgressBar height constraint is (max: 8, min:2)
  final double progressBarHeight;

  /// Whether to show the progress bar or not.
  /// Default is [true]
  final bool showProgressBar;

  /// Disable Multiple tap on the toast
  /// Default value is false
  final bool disableMultiTapping;

  /// The position of the toast in the screen where it will slide from.
  /// Default is [ToastPosition.bottom]
  final ToastPosition toastStartPosition;

  /// The toast alignment in the screen where it will stop.
  /// If the [ToastPosition] is top,
  /// then the [Alignment] should be top center/left/right.
  /// So that it will slide from top to the top center/left/right.
  /// Otherwise, the slide will not look good.
  /// Default is [Alignment.bottomCenter]
  final Alignment toastAlignment;

  /// The padding around the toast.
  /// Provide this according to the toast start position and alignment.
  /// Default is [EdgeInsets.all(10)]
  final EdgeInsets padding;

  const SlidingToastSetting({
    this.maxWidth,
    this.maxHeight,
    this.curve = Curves.elasticOut,
    this.animationDuration = const Duration(seconds: 1),
    this.displayDuration = const Duration(seconds: 1),
    this.showReverseAnimation = true,
    this.showProgressBar = true,
    this.progressBarHeight = 3,
    this.disableMultiTapping = false,
    this.toastStartPosition = ToastPosition.bottom,
    this.toastAlignment = Alignment.bottomCenter,
    this.padding = const EdgeInsets.all(10),
  });

  SlidingToastSetting copyWith({
    double? maxWidth,
    double? maxHeight,
    Curve? curve,
    Duration? animationDuration,
    Duration? displayDuration,
    bool? showReverseAnimation,
    double? progressBarHeight,
    bool? showProgressBar,
    bool? disableMultiTapping,
    ToastPosition? toastStartPosition,
    Alignment? toastAlignment,
    EdgeInsets? padding,
  }) {
    return SlidingToastSetting(
      maxWidth: maxWidth ?? this.maxWidth,
      maxHeight: maxHeight ?? this.maxHeight,
      curve: curve ?? this.curve,
      animationDuration: animationDuration ?? this.animationDuration,
      displayDuration: displayDuration ?? this.displayDuration,
      showReverseAnimation: showReverseAnimation ?? this.showReverseAnimation,
      progressBarHeight: progressBarHeight ?? this.progressBarHeight,
      showProgressBar: showProgressBar ?? this.showProgressBar,
      disableMultiTapping: disableMultiTapping ?? this.disableMultiTapping,
      toastStartPosition: toastStartPosition ?? this.toastStartPosition,
      toastAlignment: toastAlignment ?? this.toastAlignment,
      padding: padding ?? this.padding,
    );
  }
}
