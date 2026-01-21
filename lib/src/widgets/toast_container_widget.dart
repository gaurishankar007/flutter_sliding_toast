import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/toast_style.dart';

class ToastContainerWidget extends StatelessWidget {
  /// A container to display a toast message
  const ToastContainerWidget({
    super.key,
    required this.leading,
    required this.title,
    required this.trailing,
    this.toastStyle = const ToastStyle(),
    required this.expandTitleWidth,
  });

  /// The widget to display at the start of the message
  final Widget? leading;

  /// The message to display in the toast
  /// It's width is expanded whenever leading or trailing widget is present
  final Widget title;

  /// The widget to display at the end of the message
  final Widget? trailing;

  /// Styling of the toast
  final ToastStyle toastStyle;

  /// Expand the width of the title
  final bool expandTitleWidth;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = toastStyle.backgroundColor;

    /// Adding transparency in background color for glassy effect
    if (toastStyle.glassBlur != null) {
      backgroundColor = backgroundColor.withAlpha(
        ((toastStyle.backgroundColorOpacity ?? .8) * .255).toInt(),
      );
    }

    Widget child = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: toastStyle.widgetCrossAxisAlignment,
      children: [
        if (leading != null)
          Padding(
            padding: EdgeInsets.only(right: toastStyle.titleLeadingGap),
            child: leading,
          ),
        if (expandTitleWidth)
          Expanded(child: title)
        else
          Flexible(child: title),
        if (trailing != null)
          Padding(
            padding: EdgeInsets.only(left: toastStyle.titleTrailingGap),
            child: trailing,
          ),
      ],
    );

    child = Container(
      constraints: const BoxConstraints(),
      padding: toastStyle.padding ?? const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: toastStyle.gradient,
        image: toastStyle.image,
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
