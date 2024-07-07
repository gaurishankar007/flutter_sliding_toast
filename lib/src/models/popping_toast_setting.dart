import 'package:flutter/material.dart';

import '../enums/toast_position.dart';

/// The setting for the sliding animation
@immutable
class PoppingToastSetting {
  /// The maximum width of the toast
  /// Default is [80% of the screen width]
  final double? maxWidth;

  /// The maximum height of the toast
  /// Default is [40% of the screen height]
  final double? maxHeight;

  /// Should the toast be faded or not
  /// Default is true
  final bool showFading;

  /// Should the toast be faded or not
  /// Default is true
  final bool showScaling;

  /// The fading behavior of the toast.
  /// Default is [Curves.easeOut]
  final Curve fadingCurve;

  /// The scaling behavior of the toast.
  /// Default is [Curves.bounceOut]
  final Curve scalingCurve;

  /// How long the toast will fade.
  /// Default is [Duration(milliSeconds: 500)]
  final Duration animationDuration;

  /// How long the toast will be displayed
  /// after the completion of the animation.
  /// Default is [Duration(seconds: 1)]
  final Duration displayDuration;

  /// Whether to show the reverse animation or not to dismiss the toast.
  /// Default is [true]
  final bool showReverseAnimation;

  /// Disable Multiple tap on the toast
  /// Default value is false
  final bool disableMultiTapping;

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

  const PoppingToastSetting({
    this.maxWidth,
    this.maxHeight,
    this.showFading = true,
    this.showScaling = true,
    this.fadingCurve = Curves.easeOut,
    this.scalingCurve = Curves.elasticOut,
    this.animationDuration = const Duration(microseconds: 500),
    this.displayDuration = const Duration(seconds: 1),
    this.showReverseAnimation = true,
    this.disableMultiTapping = false,
    this.toastAlignment = Alignment.bottomCenter,
    this.padding = const EdgeInsets.all(10),
  });

  PoppingToastSetting copyWith({
    double? maxWidth,
    double? maxHeight,
    bool? showFading,
    bool? showScaling,
    Curve? fadingCurve,
    Curve? scalingCurve,
    Duration? animationDuration,
    Duration? displayDuration,
    bool? showReverseAnimation,
    bool? disableMultiTapping,
    Alignment? toastAlignment,
    EdgeInsets? padding,
  }) {
    return PoppingToastSetting(
      maxWidth: maxWidth ?? this.maxWidth,
      maxHeight: maxHeight ?? this.maxHeight,
      showFading: showFading ?? this.showFading,
      showScaling: showScaling ?? this.showScaling,
      fadingCurve: fadingCurve ?? this.fadingCurve,
      scalingCurve: scalingCurve ?? this.scalingCurve,
      animationDuration: animationDuration ?? this.animationDuration,
      displayDuration: displayDuration ?? this.displayDuration,
      showReverseAnimation: showReverseAnimation ?? this.showReverseAnimation,
      disableMultiTapping: disableMultiTapping ?? this.disableMultiTapping,
      toastAlignment: toastAlignment ?? this.toastAlignment,
      padding: padding ?? this.padding,
    );
  }
}
