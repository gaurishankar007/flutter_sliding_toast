import 'package:flutter/widgets.dart';

import 'package:flutter_sliding_toast/src/enums/toast_position.dart';
import 'package:flutter_sliding_toast/src/models/toast_dialog_setting.dart';

/// The setting for the sliding animation
@immutable
class const SlidingToastSetting({
  /// The maximum width of the toast
  /// Default is [80% of the screen width]
  final double? maxWidth,

  /// The maximum height of the toast
  /// Default is [40% of the screen height]
  final double? maxHeight,

  /// The sliding behavior of the animation.
  /// Default is [Curves.elasticOut]
  final Curve curve = Curves.elasticOut,

  /// How long the toast will slide.
  /// Default is [Duration(seconds: 1)]
  final Duration animationDuration = const Duration(seconds: 1),

  /// How long the toast will be displayed
  /// after the completion of the animation.
  /// Default is [Duration(seconds: 1)]
  final Duration displayDuration = const Duration(seconds: 1),

  /// Whether to show the reverse animation or not to dismiss the toast.
  /// Default is true
  final bool showReverseAnimation = true,

  /// Whether to show the progress bar or not.
  /// Default is true
  final bool showProgressBar = true,

  /// The height of the progress bar.
  /// Default is [3]
  /// ProgressBar height constraint is (max: 8, min:2)
  final double progressBarHeight = 3,

  /// Disable Multiple tap on the toast
  /// Default value is false
  final bool disableMultiTapping = false,

  /// The position of the toast in the screen where it will slide from.
  /// Default is [ToastPosition.bottom]
  final ToastPosition toastStartPosition = .bottom,

  /// The toast alignment in the screen where it will stop.
  /// If the [ToastPosition] is top,
  /// then the [Alignment] should be top center/left/right.
  /// So that it will slide from top to the top center/left/right.
  /// Otherwise, the slide will not look good.
  /// Default is [Alignment.bottomCenter]
  final Alignment toastAlignment = .bottomCenter,

  /// The padding around the toast.
  /// Provide this according to the toast start position and alignment.
  /// Default is [EdgeInsets.all(10)]
  final EdgeInsets padding = const .all(10),

  /// Whether to show the whole toast content in a dialog styled like
  /// the toast when it's tapped, useful for long messages.
  /// The toast is paused while the dialog is open.
  /// Default is false
  final bool showDialogOnTap = false,

  /// The setting for the dialog shown when [showDialogOnTap] is true.
  final ToastDialogSetting dialogSetting = const ToastDialogSetting(),
}) {
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
    bool? showDialogOnTap,
    ToastDialogSetting? dialogSetting,
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
      showDialogOnTap: showDialogOnTap ?? this.showDialogOnTap,
      dialogSetting: dialogSetting ?? this.dialogSetting,
    );
  }
}
