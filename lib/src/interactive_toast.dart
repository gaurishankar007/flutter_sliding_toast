import 'dart:collection' show Queue;

import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:flutter_sliding_toast/src/core/unique_string_generator.dart';
import 'package:flutter_sliding_toast/src/views/toast_popup.dart';
import 'package:flutter_sliding_toast/src/views/toast_slider.dart';
import 'package:material_ui/material_ui.dart';

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

  /// Inserts the overlay entry built by [builder], wires it to a
  /// [ToastController], and registers that controller so [closeAllToast]
  /// can reach it later. Shared by [slide] and [pop].
  static ToastController _show({
    required BuildContext? context,
    required OverlayState? overlayState,
    required Widget Function(ToastController toastController) builder,
    required void Function()? onDisposed,
  }) {
    /// Updating global values if they are configured before
    final resolvedContext = context ?? _context;

    /// A stale/disposed overlay state cannot host a new entry,
    /// fall back to the context in that case.
    final providedOverlayState = overlayState ?? _overlayState;
    final resolvedOverlayState = providedOverlayState?.mounted == true
        ? providedOverlayState
        : null;

    /// Don't show the toast if both overlay and mounted context are not provided
    if (resolvedContext?.mounted != true && resolvedOverlayState == null) {
      return ToastController.empty();
    }

    late final ToastController toastController;

    /// Overlay and overlay entry and passing toast controller to dispose
    /// the overlay whenever the animation is finished
    final newOverlayState =
        resolvedOverlayState ?? Overlay.of(resolvedContext!);
    final overlayEntry = OverlayEntry(
      builder: (context) => builder(toastController),
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
    return _show(
      context: context,
      overlayState: overlayState,
      onDisposed: onDisposed,
      builder: (toastController) => ToastSlider(
        toastController: toastController,
        leading: leading,
        title: title,
        trailing: trailing,
        toastSetting: toastSetting,
        toastStyle: toastStyle,
        onTapped: onTapped,
      ),
    );
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
    return _show(
      context: context,
      overlayState: overlayState,
      onDisposed: onDisposed,
      builder: (toastController) => ToastPopup(
        toastController: toastController,
        leading: leading,
        title: title,
        trailing: trailing,
        toastSetting: toastSetting,
        toastStyle: toastStyle,
        onTapped: onTapped,
      ),
    );
  }

  /// Close all the toasts one by one
  static void closeAllToast() {
    while (_toastControllers.isNotEmpty) {
      _toastControllers.removeFirst().closeToast();
    }
  }

  /// A fixed trailing icon for the deprecated status toasts below.
  static Widget _statusIcon(IconData icon, Color color, double? size) {
    return Icon(icon, color: color, size: size);
  }

  /// A fixed box shadow and progress bar color for the deprecated
  /// status toasts below.
  static ToastStyle _statusStyle(
    ToastStyle toastStyle,
    Color color,
    double shadowOpacity,
  ) {
    return toastStyle.copyWith(
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: shadowOpacity),
          blurRadius: 5,
          spreadRadius: 3,
          offset: const Offset(2, 2),
        ),
      ],
      progressBarColor: color,
    );
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
      trailing: _statusIcon(
        Icons.check_circle_rounded,
        Colors.green,
        checkIconSize,
      ),
      toastSetting: toastSetting,
      toastStyle: _statusStyle(toastStyle, Colors.green, .15),
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
      trailing: _statusIcon(Icons.warning_rounded, Colors.red, checkIconSize),
      toastSetting: toastSetting.copyWith(
        disableMultiTapping: disableMultiTapping,
      ),
      toastStyle: _statusStyle(toastStyle, Colors.red, .1),
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
      trailing: _statusIcon(
        Icons.check_circle_rounded,
        Colors.green,
        checkIconSize,
      ),
      toastSetting: toastSetting,
      toastStyle: _statusStyle(toastStyle, Colors.green, .15),
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
      trailing: _statusIcon(Icons.warning_rounded, Colors.red, checkIconSize),
      toastSetting: toastSetting.copyWith(
        disableMultiTapping: disableMultiTapping,
      ),
      toastStyle: _statusStyle(toastStyle, Colors.red, .1),
      onDisposed: onDisposed,
      onTapped: onTapped,
    );
  }
}
