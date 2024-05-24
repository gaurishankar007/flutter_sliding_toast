import 'package:flutter/material.dart';

class ToastPositionWidget extends StatelessWidget {
  final Alignment alignment;
  final EdgeInsets padding;
  final double? maxWidth;
  final double? maxHeight;
  final Widget child;

  /// A widget to position the toast in the screen
  /// with the given toast start position and alignment
  const ToastPositionWidget({
    super.key,
    this.maxWidth,
    this.maxHeight,
    required this.alignment,
    required this.padding,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Defining the constraints for the toast
    final size = MediaQuery.of(context).size;

    double minHeight = 20;
    double minWidth = size.width * .2;
    double newMaxHeight = size.height * .4;
    double newMaxWidth = size.width * 0.8;

    if ((maxHeight ?? 0) > newMaxHeight) newMaxHeight = maxHeight!;
    if ((maxWidth ?? 0) > newMaxWidth) newMaxWidth = maxWidth!;

    // SafeArea is used to avoid the status bar and the bottom navigation bar of the device
    return SafeArea(
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: padding,
          // Wrapping with the material so that it will adapt material design
          // Otherwise, the widget will look bulky/horrible
          child: Material(
            // Providing transparent color to make the toast background transparent
            // when dismissed by the user, otherwise the background will be white
            // and the toast behind it will not be visible while dismissing by sliding the toast
            color: Colors.transparent,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: minHeight,
                minWidth: minWidth,
                maxHeight: newMaxHeight,
                maxWidth: newMaxWidth,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
