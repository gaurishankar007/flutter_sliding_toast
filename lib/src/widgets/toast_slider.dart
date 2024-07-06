import 'package:flutter/material.dart';

import '../../flutter_sliding_toast.dart';
import 'toast_container_widget.dart';
import 'toast_position_widget.dart';
import 'toast_progress_bar_widget.dart';

class ToastSlider extends StatefulWidget {
  /// The toast controller for removing the overlay
  final ToastController toastController;

  /// The widget to display at the start of the message
  final Widget? leading;

  /// The Message to be displayed at the toast
  /// It's width is expanded whenever leading or trailing widget is present
  final Widget title;

  /// A widget displayed at the right side of the toast
  final Widget? trailing;

  /// The setting for the sliding animation
  final ToastSetting toastSetting;

  /// The style of the toast
  final ToastStyle toastStyle;

  /// Function to be called when the toast is disposed
  final Function()? onDisposed;

  /// Function to be called when the toast is clicked
  final Function()? onTapped;

  /// A sliding message to show the toast
  const ToastSlider({
    super.key,
    required this.toastController,
    required this.leading,
    required this.title,
    required this.trailing,
    required this.toastSetting,
    required this.toastStyle,
    this.onDisposed,
    this.onTapped,
  });

  @override
  State<ToastSlider> createState() => _ToastSliderState();
}

class _ToastSliderState extends State<ToastSlider>
    with TickerProviderStateMixin {
  late final ToastSetting toastSetting;
  late final ToastStyle toastStyle;
  late final AnimationController slideController;
  late final AnimationController sizeController;
  late final Animation<Offset> slideAnimation;
  late final Animation<double> sizeAnimation;

  /// Is the toast clicked by the user
  bool isToastTapped = false;

  @override
  void initState() {
    super.initState();
    toastSetting = widget.toastSetting;
    toastStyle = widget.toastStyle;

    /// For sliding effect
    slideController = AnimationController(
      vsync: this,
      duration: toastSetting.animationDuration,
    );

    /// For displaying the toast and also for progress bar
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
    sizeController.addStatusListener(removeOverlay);
  }

  removeOverlay(AnimationStatus status) async {
    if (status == AnimationStatus.completed) {
      // Wait for the reverse animation to complete
      if (toastSetting.showReverseAnimation) await slideController.reverse();
      // Remove the overlay entry
      widget.toastController.closeToast();
      // Execute the on disposed function
      widget.onDisposed?.call();
    }
  }

  @override
  void dispose() {
    slideController.dispose();
    sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Create the toast container
    Widget child = ToastContainerWidget(
      leading: widget.leading,
      title: widget.title,
      trailing: widget.trailing,
      toastStyle: toastStyle,
    );

    // Show the progress bar if available
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

    // Show the clipping with border radius
    child = ClipRRect(
      borderRadius: toastStyle.borderRadius,
      child: child,
    );

    // Show the box shadow if available
    if (toastStyle.boxShadow != null) {
      child = Container(
        decoration: BoxDecoration(
          boxShadow: toastStyle.boxShadow,
        ),
        child: child,
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
        // Stop animations and remove the overlay on dismissed
        onDismissed: (_) {
          sizeController.stop();
          widget.toastController.closeToast();
        },
        child: GestureDetector(
          // Execute onTapped function on tap
          onTap: () {
            if (!isToastTapped) widget.onTapped?.call();
            if (widget.toastSetting.disableMultiTapping) isToastTapped = true;
          },
          // Pause the animation on long press
          onLongPress: () => sizeController.stop(),
          // Forward the animation when long press ends
          onLongPressEnd: (details) => sizeController.forward(),
          child: SlideTransition(
            position: slideAnimation,
            child: child,
          ),
        ),
      ),
    );
  }
}
