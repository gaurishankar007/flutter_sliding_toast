import 'package:flutter/material.dart';

import '../../flutter_sliding_toast.dart';
import '../widgets/toast_container_widget.dart';
import '../widgets/toast_position_widget.dart';

class ToastPopup extends StatefulWidget {
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
  final PopupToastSetting toastSetting;

  /// The style of the toast
  final ToastStyle toastStyle;

  /// Function to be called when the toast is disposed
  final Function()? onDisposed;

  /// Function to be called when the toast is clicked
  final Function()? onTapped;

  /// A sliding message to show the toast
  const ToastPopup({
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
  State<ToastPopup> createState() => _ToastPopupState();
}

class _ToastPopupState extends State<ToastPopup> with TickerProviderStateMixin {
  late final PopupToastSetting toastSetting;
  late final ToastStyle toastStyle;
  late final AnimationController fadeController;
  late final AnimationController scaleController;
  late final AnimationController timeController;
  late final Animation<double> fadeAnimation;
  late final Animation<double> scaleAnimation;

  /// If at least one animation is allowed to show
  bool showAnimation = true;

  /// Is the toast clicked by the user
  bool isToastTapped = false;

  @override
  void initState() {
    super.initState();
    toastSetting = widget.toastSetting;
    toastStyle = widget.toastStyle;
    showAnimation = toastSetting.showFading || toastSetting.showScaling;

    /// For sliding effect
    fadeController = AnimationController(
      vsync: this,
      duration: toastSetting.animationDuration,
    );

    /// For displaying the toast and also for progress bar
    scaleController = AnimationController(
      vsync: this,
      duration: toastSetting.animationDuration,
    );

    /// For tracking the animation and display duration
    Duration duration = toastSetting.displayDuration;
    if (showAnimation) duration += toastSetting.animationDuration;
    timeController = AnimationController(vsync: this, duration: duration);

    // Create a curved tween animation for the slide
    fadeAnimation = Tween<double>(
      begin: .1,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: fadeController,
        curve: toastSetting.fadingCurve,
      ),
    );

    // Create a size animation for the progress bar
    scaleAnimation = Tween<double>(
      begin: .5,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: scaleController,
        curve: toastSetting.scalingCurve,
      ),
    );

    // Start the animation
    fadeController.forward();

    // Start the size animation
    scaleController.forward();

    // Start the time controller
    timeController.forward();

    // listen animation is completed or not to remove the overlay
    timeController.addStatusListener(animationListener);
  }

  animationListener(status) async {
    if (status == AnimationStatus.completed) {
      // Wait for the reverse animation to complete
      if (showAnimation && toastSetting.showReverseAnimation) {
        fadeController.reverse();
        await scaleController.reverse();
      }

      // Remove the overlay entry
      widget.toastController.closeToast();
    }
  }

  @override
  void dispose() {
    fadeController.dispose();
    scaleController.dispose();
    timeController.dispose();
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
      expandTitleWidth: toastStyle.expandedTitle,
    );

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

    if (toastSetting.showFading) {
      child = FadeTransition(
        opacity: fadeAnimation,
        child: child,
      );
    }

    if (toastSetting.showScaling) {
      child = ScaleTransition(
        scale: scaleAnimation,
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
        direction: DismissDirection.horizontal,
        // Stop animations and remove the overlay on dismissed
        onDismissed: (_) {
          if (showAnimation) timeController.stop();
          widget.toastController.closeToast();
        },
        child: GestureDetector(
          // Execute onTapped function on tap
          onTap: () {
            if (!isToastTapped) widget.onTapped?.call();
            if (widget.toastSetting.disableMultiTapping) isToastTapped = true;
          },
          // Pause the animation on long press
          onLongPress: () => timeController.stop(),
          // Forward the animation when long press ends
          onLongPressEnd: (details) => timeController.forward(),
          child: child,
        ),
      ),
    );
  }
}
