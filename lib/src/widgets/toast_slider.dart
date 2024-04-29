import 'package:flutter/material.dart';

import '../toast_setting.dart';
import '../toast_style.dart';
import 'toast_container_widget.dart';
import 'toast_position_widget.dart';
import 'toast_progress_bar_widget.dart';

class ToastSlider extends StatefulWidget {
  /// The overlay entry to show the toast
  final OverlayEntry overlayEntry;

  /// The title to display in the toast
  final Widget title;

  /// The icon to display at the right side of the toast
  final Widget? trailing;

  /// The setting for the sliding animation
  final ToastSetting toastSetting;

  /// The style of the toast
  final ToastStyle toastStyle;

  /// A sliding message to show the toast
  const ToastSlider({
    super.key,
    required this.overlayEntry,
    required this.title,
    required this.trailing,
    required this.toastSetting,
    required this.toastStyle,
  });

  @override
  State<ToastSlider> createState() => _ToastSliderState();
}

class _ToastSliderState extends State<ToastSlider> with TickerProviderStateMixin {
  late final ToastSetting toastSetting;
  late final ToastStyle toastStyle;
  late final AnimationController slideController;
  late final AnimationController sizeController;
  late final Animation<Offset> slideAnimation;
  late final Animation<double> sizeAnimation;

  /// Whether the toast is dismissed or not by the user
  bool isDismissed = false;

  @override
  void initState() {
    super.initState();
    toastSetting = widget.toastSetting;
    toastStyle = widget.toastStyle;

    slideController = AnimationController(
      vsync: this,
      duration: toastSetting.animationDuration,
    );

    sizeController = AnimationController(
      vsync: this,
      duration: toastSetting.animationDuration + toastSetting.displayDuration,
    );

    // Get tween according to the start direction
    final tween = toastSetting.toastStartPosition.tween();

    // Create a curved tween animation for the slide
    slideAnimation = tween.animate(
      CurvedAnimation(
        parent: slideController,
        curve: toastSetting.curve,
      ),
    );

    // Create a size animation for the progress bar
    sizeAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(sizeController);

    // Start the animation
    slideController.forward();

    // Start the size animation
    sizeController.forward();

    // listen animation is completed or not to remove the overlay
    slideController.addStatusListener(removeOverlay);
  }

  removeOverlay(AnimationStatus status) async {
    if (status == AnimationStatus.completed) {
      // Wait for the display duration
      await Future.delayed(toastSetting.displayDuration);
      // Check if the toast is already dismissed and return if it is
      if (isDismissed) return;

      // Wait for the reverse animation to complete
      if (toastSetting.showReverseAnimation) await slideController.reverse();
      if (isDismissed) return;

      widget.overlayEntry.remove();
    }
  }

  @override
  void dispose() {
    slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Create the toast container
    Widget child = ToastContainerWidget(
      title: widget.title,
      trailing: widget.trailing,
      toastStyle: toastStyle,
    );

    // Add progress bar if required
    if (toastSetting.showProgressBar) {
      child = Stack(
        alignment: Alignment.bottomLeft,
        children: [
          child,
          ToastProgressBarWidget(
            animation: sizeAnimation,
            toastStyle: toastStyle,
            toastSetting: toastSetting,
          ),
        ],
      );
    }

    return ToastPositionWidget(
      alignment: toastSetting.toastAlignment,
      padding: toastSetting.padding,
      maxHeight: toastSetting.maxHeight,
      maxWidth: toastSetting.maxWidth,
      child: Dismissible(
        key: UniqueKey(),
        direction: toastSetting.toastStartPosition.dismissDirection(),
        onDismissed: (_) {
          // Stop animations and remove the overlay after
          isDismissed = true;
          slideController.stop();
          sizeController.stop();
          widget.overlayEntry.remove();
        },
        child: SlideTransition(
          position: slideAnimation,
          child: child,
        ),
      ),
    );
  }
}
