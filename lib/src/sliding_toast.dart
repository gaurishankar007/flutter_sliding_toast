import 'dart:collection' show Queue;

import 'package:flutter/material.dart';

import '../flutter_sliding_toast.dart';
import 'core/unique_string_generator.dart';
import 'widgets/toast_slider.dart';

class SlidingToast {
  static final _toastControllers = Queue<ToastController>();

  static ToastController show(
    BuildContext context, {
    Widget? leading,
    required Widget title,
    Widget? trailing,
    ToastSetting toastSetting = const ToastSetting(),
    ToastStyle toastStyle = const ToastStyle(),
    Function()? onDisposed,
    Function()? onTapped,
  }) {
    /// Check if the context is still mounted.
    /// If not, do not show the toast.
    if (!context.mounted) return ToastController.empty();

    /// Toast Controller for the overlay
    late final ToastController toastController;

    /// Overlay and overlay entry and passing toast controller to dispose
    /// the overlay whenever the animation is finished
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => ToastSlider(
        toastController: toastController,
        leading: leading,
        title: title,
        trailing: trailing,
        toastSetting: toastSetting,
        toastStyle: toastStyle,
        onDisposed: onDisposed,
        onTapped: onTapped,
      ),
    );
    overlay.insert(overlayEntry);

    /// Inserting toast controller to a list
    String toastId = getUniqueString();
    toastController = ToastController(
      id: toastId,
      closeToast: () {
        if (overlayEntry.mounted) {
          overlayEntry.remove();
          overlayEntry.dispose();
        }

        /// Removing toast from the list
        _toastControllers.removeWhere((e) => e.id == toastId);
      },
    );

    /// Adding toast to the list
    _toastControllers.add(toastController);

    return toastController;
  }

  /// Close all the toasts one by one
  static closeAllToast() {
    while (_toastControllers.isNotEmpty) {
      _toastControllers.removeFirst().closeToast();
    }
  }

  /// Default toast for showing success message
  /// The icon and box shadow for this toast is fixed
  static ToastController showSuccess(
    BuildContext context, {
    required Widget title,
    double? checkIconSize,
    bool showProgressBar = true,
    ToastSetting toastSetting = const ToastSetting(),
    ToastStyle toastStyle = const ToastStyle(),
    Function()? onDisposed,
    Function()? onTapped,
  }) {
    return show(
      context,
      title: title,
      trailing: Icon(
        Icons.check_circle_rounded,
        color: Colors.green,
        size: checkIconSize,
      ),
      toastSetting: toastSetting,
      toastStyle: toastStyle.copyWith(
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(.15),
            blurRadius: 5,
            spreadRadius: 3,
            offset: const Offset(2, 2),
          )
        ],
        progressBarColor: Colors.green,
      ),
      onDisposed: onDisposed,
      onTapped: onTapped,
    );
  }

  /// Default toast for showing error message
  /// The icon and box shadow for this toast is fixed
  static ToastController showError(
    BuildContext context, {
    required Widget title,
    double? checkIconSize,
    bool showProgressBar = true,
    ToastSetting toastSetting = const ToastSetting(),
    ToastStyle toastStyle = const ToastStyle(),
    Function()? onDisposed,
    Function()? onTapped,
    bool disableMultiTapping = false,
  }) {
    return show(
      context,
      title: title,
      trailing: Icon(
        Icons.warning_rounded,
        color: Colors.red,
        size: checkIconSize,
      ),
      toastSetting: toastSetting,
      toastStyle: toastStyle.copyWith(
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(.1),
            blurRadius: 5,
            spreadRadius: 3,
            offset: const Offset(2, 2),
          )
        ],
        progressBarColor: Colors.red,
      ),
      onDisposed: onDisposed,
      onTapped: onTapped,
    );
  }
}
