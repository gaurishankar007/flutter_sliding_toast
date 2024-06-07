import 'dart:ui';

import 'package:flutter/material.dart';

import '../toast_style.dart';

class ToastContainerWidget extends StatelessWidget {
  /// The message to display in the toast
  final Widget title;

  /// The icon to display at the end of the message
  final Widget? trailing;

  /// Styling of the toast
  final ToastStyle toastStyle;

  /// A container to display a toast message
  const ToastContainerWidget({
    super.key,
    required this.title,
    required this.trailing,
    this.toastStyle = const ToastStyle(),
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = toastStyle.backgroundColor;
    Widget child = title;

    if (toastStyle.glassBlur != null) {
      backgroundColor = backgroundColor.withOpacity(
        toastStyle.backgroundColorOpacity ?? .8,
      );
    }

    if (trailing != null) {
      child = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: title,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: trailing,
          ),
        ],
      );
    }

    child = Container(
      width: double.maxFinite,
      padding: toastStyle.padding ?? const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: toastStyle.borderRadius,
        border: toastStyle.border,
      ),
      child: child,
    );

    if (toastStyle.glassBlur != null) {
      child = BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: toastStyle.glassBlur!,
          sigmaY: toastStyle.glassBlur!,
        ),
        child: child,
      );
    }

    return child;
  }
}
