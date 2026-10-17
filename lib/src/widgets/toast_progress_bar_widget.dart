import 'package:flutter_sliding_toast/src/models/sliding_toast_setting.dart';
import 'package:flutter_sliding_toast/src/models/toast_style.dart';
import 'package:material_ui/material_ui.dart';

/// A progress bar to show the remaining time left to dismiss the toast
class const ToastProgressBarWidget({
  super.key,
  required final Animation<double> animation,
  required final ToastStyle toastStyle,
  required final SlidingToastSetting toastSetting,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color color = toastStyle.progressBarColor ?? primaryColor;
    double height = toastSetting.progressBarHeight;
    height = height.clamp(2, 8);

    // Defining the height of the size transition
    // Otherwise it will take available height (maxHeight)
    return SizedBox(
      height: height,
      child: SizeTransition(
        sizeFactor: animation,
        axis: Axis.horizontal,
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withAlpha(179), color.withAlpha(102)],
            ),
          ),
        ),
      ),
    );
  }
}
