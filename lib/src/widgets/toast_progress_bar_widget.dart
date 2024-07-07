import 'package:flutter/material.dart';

import '../models/sliding_toast_setting.dart';
import '../models/toast_style.dart';

class ToastProgressBarWidget extends StatelessWidget {
  final Animation<double> animation;
  final ToastStyle toastStyle;
  final SlidingToastSetting toastSetting;

  /// A progress bar to show the remaining time left to dismiss the toast
  const ToastProgressBarWidget({
    super.key,
    required this.animation,
    required this.toastStyle,
    required this.toastSetting,
  });

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    Color color = toastStyle.progressBarColor ?? primaryColor;
    double height = toastSetting.progressBarHeight;
    height = height.clamp(2, 8);

    // Defining the height of the size transition
    // Otherwise it will take available height (maxHeight)
    return SizedBox(
      height: height,
      child: SizeTransition(
        sizeFactor: animation,
        axis: Axis.horizontal,
        axisAlignment: -1,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color,
                color.withOpacity(0.7),
                color.withOpacity(0.4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
