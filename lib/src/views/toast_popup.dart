import 'package:flutter/widgets.dart';

import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:flutter_sliding_toast/src/views/toast_dialog.dart';
import 'package:flutter_sliding_toast/src/widgets/toast_container_widget.dart';
import 'package:flutter_sliding_toast/src/widgets/toast_position_widget.dart';

/// A sliding message to show the toast
class const ToastPopup({
  super.key,

  /// The toast controller for removing the overlay
  required final ToastController toastController,

  /// The widget to display at the start of the message
  required final Widget? leading,

  /// The Message to be displayed at the toast
  /// It's width is expanded whenever leading or trailing widget is present
  required final Widget title,

  /// A widget displayed at the right side of the toast
  required final Widget? trailing,

  /// The setting for the sliding animation
  required final PopupToastSetting toastSetting,

  /// The style of the toast
  required final ToastStyle toastStyle,

  /// The message displayed in the dialog shown on tap instead of [title]
  final Widget? dialogTitle,

  /// Function to be called when the toast is clicked
  final void Function()? onTapped,
}) extends StatefulWidget {
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
    if (showAnimation) {
      duration += toastSetting.animationDuration;
    }
    timeController = AnimationController(vsync: this, duration: duration);

    // Create a curved tween animation for the slide
    fadeAnimation = Tween<double>(begin: .1, end: 1).animate(
      CurvedAnimation(parent: fadeController, curve: toastSetting.fadingCurve),
    );

    // Create a size animation for the progress bar
    scaleAnimation = Tween<double>(begin: .5, end: 1).animate(
      CurvedAnimation(
        parent: scaleController,
        curve: toastSetting.scalingCurve,
      ),
    );

    // Start the animation
    fadeController.forward();

    // Start the size animation
    scaleController.forward();

    // Start the time controller and listen animation is completed or not to remove the overlay
    timeController
      ..forward()
      ..addStatusListener(animationListener);
  }

  Future<void> animationListener(AnimationStatus status) async {
    if (status == AnimationStatus.completed) {
      // Wait for the reverse animation to complete
      if (showAnimation && toastSetting.showReverseAnimation) {
        await fadeController.reverse();
        await scaleController.reverse();
      }

      // Remove the overlay entry
      widget.toastController.closeToast();
    }
  }

  /// Shows the whole toast content in a dialog,
  /// pausing the toast until the dialog is closed.
  Future<void> showDialog() async {
    timeController.stop();
    await showToastDialog(
      context,
      leading: widget.leading,
      title: widget.dialogTitle ?? widget.title,
      trailing: widget.trailing,
      toastStyle: toastStyle,
      dialogSetting: toastSetting.dialogSetting,
      toastMaxWidth: toastSetting.maxWidth,
    );
    if (mounted) {
      timeController.forward();
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
    child = ClipRRect(borderRadius: toastStyle.borderRadius, child: child);

    // Show the box shadow if available
    if (toastStyle.boxShadow != null) {
      child = Container(
        decoration: BoxDecoration(boxShadow: toastStyle.boxShadow),
        child: child,
      );
    }

    if (toastSetting.showFading) {
      child = FadeTransition(opacity: fadeAnimation, child: child);
    }

    if (toastSetting.showScaling) {
      child = ScaleTransition(scale: scaleAnimation, child: child);
    }

    return ToastPositionWidget(
      alignment: toastSetting.toastAlignment,
      padding: toastSetting.padding,
      newMaxHeight: toastSetting.maxHeight,
      newMaxWidth: toastSetting.maxWidth,
      child: Dismissible(
        key: UniqueKey(),
        // Stop animations and remove the overlay on dismissed
        onDismissed: (_) {
          if (showAnimation) {
            timeController.stop();
          }
          widget.toastController.closeToast();
        },
        child: GestureDetector(
          // Execute onTapped function on tap
          onTap: () {
            if (isToastTapped) {
              return;
            }
            if (toastSetting.disableMultiTapping) {
              isToastTapped = true;
            }
            widget.onTapped?.call();
            if (toastSetting.showDialogOnTap) {
              showDialog();
            }
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
