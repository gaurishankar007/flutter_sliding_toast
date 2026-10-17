import 'dart:collection' show Queue;

import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:flutter_sliding_toast/src/core/unique_string_generator.dart';
import 'package:flutter_sliding_toast/src/views/toast_popup.dart';
import 'package:flutter_sliding_toast/src/views/toast_slider.dart';
import 'package:material_ui/material_ui.dart';

/// A toast's overlay entry, held until its turn when toasts
/// are shown one by one.
class _ToastEntry(
  final OverlayState overlayState,
  final OverlayEntry overlayEntry,
) {
  bool isInserted = false;
  bool isClosed = false;

  void insert() {
    overlayState.insert(overlayEntry);
    isInserted = true;
  }
}

class const InteractiveToast._() {
  static final _toastControllers = Queue<ToastController>();
  static BuildContext? _context;
  static OverlayState? _overlayState;
  static ToastDisplayMode _displayMode = ToastDisplayMode.allAtOnce;

  /// Toasts waiting for their turn in [ToastDisplayMode.oneByOne].
  static final _pendingToasts = Queue<_ToastEntry>();

  /// The one-by-one toast on screen, holding back the pending ones.
  static _ToastEntry? _shownToast;

  /// Initialize context early so that toasts can be shown without context later.
  static void initializeContext(BuildContext context) => _context = context;

  /// Initialize overlay state early so that toasts can be shown without overlay state later.
  static void initializeOverlayState(OverlayState overlayState) =>
      _overlayState = overlayState;

  /// How toasts are shown when no display mode is given to [slide] or [pop].
  /// Default is [ToastDisplayMode.allAtOnce]
  static ToastDisplayMode get displayMode => _displayMode;

  /// Set how toasts are shown when no display mode is given to [slide] or [pop].
  static void setDisplayMode(ToastDisplayMode displayMode) =>
      _displayMode = displayMode;

  /// Builds the overlay entry with [builder], wires it to a
  /// [ToastController], and registers that controller so [closeAllToast]
  /// can reach it later. The entry is inserted right away, or queued
  /// when [displayMode] is [ToastDisplayMode.oneByOne].
  /// Shared by [slide] and [pop].
  static ToastController _show({
    required BuildContext? context,
    required OverlayState? overlayState,
    required ToastDisplayMode? displayMode,
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

    /// The overlay is resolved now, since it outlives a screen
    /// that pops before a queued toast's turn.
    final toast = _ToastEntry(
      resolvedOverlayState ?? Overlay.of(resolvedContext!),
      OverlayEntry(builder: (context) => builder(toastController)),
    );

    final String toastId = getUniqueString();
    toastController = ToastController(
      id: toastId,
      closeToast: () {
        if (toast.isClosed) {
          return;
        }
        toast.isClosed = true;

        /// Removing toast from the queue and the list
        _pendingToasts.remove(toast);
        _toastControllers.removeWhere((e) => e.id == toastId);

        /// Removing the overlay, only a shown toast is disposed
        if (toast.isInserted) {
          toast.overlayEntry.remove();
          onDisposed?.call();
        }
        toast.overlayEntry.dispose();

        /// Showing the next toast in the queue
        if (identical(_shownToast, toast)) {
          _shownToast = null;
          _showNextToast();
        }
      },
    );

    /// Adding toast to the list
    _toastControllers.add(toastController);

    if ((displayMode ?? _displayMode) == ToastDisplayMode.oneByOne) {
      _enqueue(toast);
    } else {
      toast.insert();
    }

    return toastController;
  }

  /// Queues [toast], showing it now if no one-by-one toast is on screen.
  static void _enqueue(_ToastEntry toast) {
    /// Free the slot if the shown toast's overlay was torn down
    /// (e.g. hot restart), since it never gets closed then.
    if (_shownToast?.overlayState.mounted == false) {
      _shownToast = null;
    }

    _pendingToasts.add(toast);
    if (_shownToast == null) {
      _showNextToast();
    }
  }

  /// Shows the next pending toast whose overlay is still around.
  static void _showNextToast() {
    while (_pendingToasts.isNotEmpty) {
      final toast = _pendingToasts.removeFirst();
      if (!toast.overlayState.mounted) {
        continue;
      }

      toast.insert();
      _shownToast = toast;
      return;
    }
  }

  /// If [overlayState] is provided, then [context] will not be used.
  /// If [displayMode] is not provided, then [InteractiveToast.displayMode] is used.
  /// [dialogTitle] is shown instead of [title] in the dialog
  /// when [SlidingToastSetting.showDialogOnTap] is true.
  static ToastController slide({
    BuildContext? context,
    OverlayState? overlayState,
    Widget? leading,
    required Widget title,
    Widget? dialogTitle,
    Widget? trailing,
    SlidingToastSetting toastSetting = const SlidingToastSetting(),
    ToastStyle toastStyle = const ToastStyle(),
    ToastDisplayMode? displayMode,
    void Function()? onDisposed,
    void Function()? onTapped,
  }) {
    return _show(
      context: context,
      overlayState: overlayState,
      displayMode: displayMode,
      onDisposed: onDisposed,
      builder: (toastController) => ToastSlider(
        toastController: toastController,
        leading: leading,
        title: title,
        dialogTitle: dialogTitle,
        trailing: trailing,
        toastSetting: toastSetting,
        toastStyle: toastStyle,
        onTapped: onTapped,
      ),
    );
  }

  /// If [overlayState] is provided, then [context] will not be used.
  /// If [displayMode] is not provided, then [InteractiveToast.displayMode] is used.
  /// [dialogTitle] is shown instead of [title] in the dialog
  /// when [PopupToastSetting.showDialogOnTap] is true.
  static ToastController pop({
    BuildContext? context,
    OverlayState? overlayState,
    Widget? leading,
    required Widget title,
    Widget? dialogTitle,
    Widget? trailing,
    PopupToastSetting toastSetting = const PopupToastSetting(),
    ToastStyle toastStyle = const ToastStyle(),
    ToastDisplayMode? displayMode,
    void Function()? onDisposed,
    void Function()? onTapped,
  }) {
    return _show(
      context: context,
      overlayState: overlayState,
      displayMode: displayMode,
      onDisposed: onDisposed,
      builder: (toastController) => ToastPopup(
        toastController: toastController,
        leading: leading,
        title: title,
        dialogTitle: dialogTitle,
        trailing: trailing,
        toastSetting: toastSetting,
        toastStyle: toastStyle,
        onTapped: onTapped,
      ),
    );
  }

  /// Close all the toasts one by one, including the queued ones
  static void closeAllToast() {
    /// Dropping the queue first, so closing the shown toast
    /// doesn't bring in the next one
    _pendingToasts.clear();
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
