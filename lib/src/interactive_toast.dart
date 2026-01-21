import 'dart:collection' show Queue;

import 'package:flutter/material.dart';

import '../flutter_sliding_toast.dart';
import 'core/unique_string_generator.dart';
import 'views/toast_popup.dart';
import 'views/toast_slider.dart';

class InteractiveToast {
  const InteractiveToast._();

  static final _toastControllers = Queue<ToastController>();
  static BuildContext? _context;
  static OverlayState? _overlayState;

  /// Initialize context early so that toasts can be shown without context later.
  static void initializeContext(BuildContext context) => _context = context;

  /// Initialize overlay state early so that toasts can be shown without overlay state later.
  static void initializeOverlayState(OverlayState overlayState) =>
      _overlayState = overlayState;

  /// If [overlayState] is provided, then [context] will not be used.
  static ToastController slide({
    BuildContext? context,
    OverlayState? overlayState,
    Widget? leading,
    required Widget title,
    Widget? trailing,
    SlidingToastSetting toastSetting = const SlidingToastSetting(),
    ToastStyle toastStyle = const ToastStyle(),
    void Function()? onDisposed,
    void Function()? onTapped,
  }) {
    /// Updating global values if they are configured before
    context ??= _context;
    overlayState ??= _overlayState;

    /// Don't show the toast if both overlay and mounted context are not provided
    if (context?.mounted != true && overlayState == null) {
      return ToastController.empty();
    }

    late final OverlayState newOverlayState;
    late final ToastController toastController;

    /// Overlay and overlay entry and passing toast controller to dispose
    /// the overlay whenever the animation is finished
    newOverlayState = overlayState ?? Overlay.of(context!);
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
    newOverlayState.insert(overlayEntry);

    /// Inserting toast controller to a list
    final String toastId = getUniqueString();
    toastController = ToastController(
      id: toastId,
      closeToast: () {
        if (overlayEntry.mounted) {
          overlayEntry
            ..remove()
            ..dispose();
          onDisposed?.call();
        }

        /// Removing toast from the list
        _toastControllers.removeWhere((e) => e.id == toastId);
      },
    );

    /// Adding toast to the list
    _toastControllers.add(toastController);

    return toastController;
  }

  /// If [overlayState] is provided, then [context] will not be used.
  static ToastController pop({
    BuildContext? context,
    OverlayState? overlayState,
    Widget? leading,
    required Widget title,
    Widget? trailing,
    PopupToastSetting toastSetting = const PopupToastSetting(),
    ToastStyle toastStyle = const ToastStyle(),
    void Function()? onDisposed,
    void Function()? onTapped,
  }) {
    /// Updating global values if they are configured before
    context ??= _context;
    overlayState ??= _overlayState;

    /// Don't show the toast if both overlay and mounted context are not provided
    if (context?.mounted != true && overlayState == null) {
      return ToastController.empty();
    }

    late final OverlayState newOverlayState;
    late final ToastController toastController;

    /// Overlay and overlay entry and passing toast controller to dispose
    /// the overlay whenever the animation is finished
    newOverlayState = overlayState ?? Overlay.of(context!);
    final overlayEntry = OverlayEntry(
      builder: (context) => ToastPopup(
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
    newOverlayState.insert(overlayEntry);

    /// Inserting toast controller to a list
    final String toastId = getUniqueString();
    toastController = ToastController(
      id: toastId,
      closeToast: () {
        if (overlayEntry.mounted) {
          overlayEntry
            ..remove()
            ..dispose();
          onDisposed?.call();
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
  static void closeAllToast() {
    while (_toastControllers.isNotEmpty) {
      _toastControllers.removeFirst().closeToast();
    }
  }

  /// Default toast for showing success message
  /// The icon and box shadow for this toast is fixed
  @Deprecated(
    'This method is depreciated and will be removed in the future. Use the slide method instead',
  )
  static ToastController slideSuccess({
    BuildContext? context,
    OverlayState? overlayState,
    required Widget title,
    double? checkIconSize,
    bool showProgressBar = true,
    SlidingToastSetting toastSetting = const SlidingToastSetting(),
    ToastStyle toastStyle = const ToastStyle(),
    void Function()? onDisposed,
    void Function()? onTapped,
  }) {
    return slide(
      context: context,
      overlayState: overlayState,
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
          ),
        ],
        progressBarColor: Colors.green,
      ),
      onDisposed: onDisposed,
      onTapped: onTapped,
    );
  }

  /// Default toast for showing error message
  /// The icon and box shadow for this toast is fixed
  @Deprecated(
    'This method is depreciated and will be removed in the future. Use the slide method instead',
  )
  static ToastController slideError({
    BuildContext? context,
    OverlayState? overlayState,
    required Widget title,
    double? checkIconSize,
    bool showProgressBar = true,
    SlidingToastSetting toastSetting = const SlidingToastSetting(),
    ToastStyle toastStyle = const ToastStyle(),
    void Function()? onDisposed,
    void Function()? onTapped,
    bool disableMultiTapping = false,
  }) {
    return slide(
      context: context,
      overlayState: overlayState,
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
          ),
        ],
        progressBarColor: Colors.red,
      ),
      onDisposed: onDisposed,
      onTapped: onTapped,
    );
  }

  /// Default toast for showing success message
  /// The icon and box shadow for this toast is fixed
  @Deprecated(
    'This method is depreciated and will be removed in the future. Use the pop method instead',
  )
  static ToastController popSuccess({
    BuildContext? context,
    OverlayState? overlayState,
    required Widget title,
    double? checkIconSize,
    PopupToastSetting toastSetting = const PopupToastSetting(),
    ToastStyle toastStyle = const ToastStyle(),
    void Function()? onDisposed,
    void Function()? onTapped,
  }) {
    return pop(
      context: context,
      overlayState: overlayState,
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
          ),
        ],
        progressBarColor: Colors.green,
      ),
      onDisposed: onDisposed,
      onTapped: onTapped,
    );
  }

  /// Default toast for showing error message
  /// The icon and box shadow for this toast is fixed
  @Deprecated(
    'This method is depreciated and will be removed in the future. Use the pop method instead',
  )
  static ToastController popError({
    BuildContext? context,
    OverlayState? overlayState,
    required Widget title,
    double? checkIconSize,
    PopupToastSetting toastSetting = const PopupToastSetting(),
    ToastStyle toastStyle = const ToastStyle(),
    void Function()? onDisposed,
    void Function()? onTapped,
    bool disableMultiTapping = false,
  }) {
    return pop(
      context: context,
      overlayState: overlayState,
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
          ),
        ],
        progressBarColor: Colors.red,
      ),
      onDisposed: onDisposed,
      onTapped: onTapped,
    );
  }
}
