import 'package:flutter/material.dart';

import 'toast_setting.dart';
import 'toast_style.dart';
import 'widgets/toast_slider.dart';

/// A class to show toast messages.
class SlidingToast {
  static show(
    BuildContext context, {
    required Widget title,
    Widget? trailing,
    ToastSetting toastSetting = const ToastSetting(),
    ToastStyle toastStyle = const ToastStyle(),
  }) {
    // Check if the context is still mounted.
    // If not, do not show the toast.
    if (!context.mounted) return;

    final overlay = Overlay.of(context);

    late final OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => ToastSlider(
        overlayEntry: overlayEntry,
        title: title,
        trailing: trailing,
        toastSetting: toastSetting,
        toastStyle: toastStyle,
      ),
    );

    overlay.insert(overlayEntry);
  }

  static showSuccess(
    BuildContext context, {
    required Widget title,
    double? checkIconSize,
    bool showProgressBar = true,
    ToastSetting toastSetting = const ToastSetting(),
    ToastStyle toastStyle = const ToastStyle(),
  }) {
    if (!context.mounted) return;

    show(
      context,
      title: title,
      trailing: Icon(
        Icons.check_circle_rounded,
        color: Colors.green,
        size: checkIconSize,
      ),
      toastSetting: toastSetting,
      toastStyle: toastStyle.copyWith(
        boxShadow: BoxShadow(
          color: Colors.green.withOpacity(.2),
          blurRadius: 5,
          spreadRadius: 3,
          offset: const Offset(2, 2),
        ),
        progressBarColor: Colors.green,
      ),
    );
  }

  static showError(
    BuildContext context, {
    required Widget title,
    double? checkIconSize,
    bool showProgressBar = true,
    ToastSetting toastSetting = const ToastSetting(),
    ToastStyle toastStyle = const ToastStyle(),
  }) {
    if (!context.mounted) return;

    show(
      context,
      title: title,
      trailing: Icon(
        Icons.warning_rounded,
        color: Colors.red,
        size: checkIconSize,
      ),
      toastSetting: toastSetting,
      toastStyle: toastStyle.copyWith(
        boxShadow: BoxShadow(
          color: Colors.red.withOpacity(.1),
          blurRadius: 5,
          spreadRadius: 3,
          offset: const Offset(2, 2),
        ),
        progressBarColor: Colors.red,
      ),
    );
  }
}
