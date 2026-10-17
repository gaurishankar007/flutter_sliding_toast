import 'package:flutter/widgets.dart';

import 'package:flutter_sliding_toast/src/enums/toast_position.dart';
import 'package:flutter_sliding_toast/src/models/toast_dialog_setting.dart';

/// The setting for the sliding animation
@immutable
class const PopupToastSetting({
  /// The maximum width of the toast
  /// Default is [80% of the screen width]
  final double? maxWidth,

  /// The maximum height of the toast
  /// Default is [40% of the screen height]
  final double? maxHeight,

  /// Should the toast be faded or not
  /// Default is true
  final bool showFading = true,

  /// Should the toast be faded or not
  /// Default is true
  final bool showScaling = true,

  /// The fading behavior of the toast.
  /// Default is [Curves.easeOut]
  final Curve fadingCurve = Curves.easeOut,

  /// The scaling behavior of the toast.
  /// Default is [Curves.bounceOut]
  final Curve scalingCurve = Curves.elasticOut,

  /// How long the toast will fade.
  /// Default is [Duration(milliSeconds: 500)]
  final Duration animationDuration = const Duration(milliseconds: 500),

  /// How long the toast will be displayed
  /// after the completion of the animation.
  /// Default is [Duration(seconds: 1)]
  final Duration displayDuration = const Duration(seconds: 1),

  /// Whether to show the reverse animation or not to dismiss the toast.
  /// Default is true
  final bool showReverseAnimation = true,

  /// Disable Multiple tap on the toast
  /// Default value is false
  final bool disableMultiTapping = false,

  /// The toast alignment in the screen where it will stop.
  /// If the [ToastPosition] is top,
  /// then the [Alignment] should be top center/left/right.
  /// So that it will slide from top to the top center/left/right.
  /// Otherwise, the slide will not look good.
  /// Default is [Alignment.bottomCenter]
  final Alignment toastAlignment = Alignment.bottomCenter,

  /// The padding around the toast.
  /// Provide this according to the toast start position and alignment.
  /// Default is [EdgeInsets.all(10)]
  final EdgeInsets padding = const EdgeInsets.all(10),

  /// Whether to show the whole toast content in a dialog styled like
  /// the toast when it's tapped, useful for long messages.
  /// The toast is paused while the dialog is open.
  /// Default is false
  final bool showDialogOnTap = false,

  /// The setting for the dialog shown when [showDialogOnTap] is true.
  final ToastDialogSetting dialogSetting = const ToastDialogSetting(),
}) {
  PopupToastSetting copyWith({
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
    bool? showDialogOnTap,
    ToastDialogSetting? dialogSetting,
  }) {
    return PopupToastSetting(
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
      showDialogOnTap: showDialogOnTap ?? this.showDialogOnTap,
      dialogSetting: dialogSetting ?? this.dialogSetting,
    );
  }
}
