import 'package:flutter_sliding_toast/src/models/sliding_toast_setting.dart';
import 'package:flutter_sliding_toast/src/models/toast_style.dart';
import 'package:material_ui/material_ui.dart';

class ToastProgressBarWidget extends StatelessWidget {
  /// A progress bar to show the remaining time left to dismiss the toast
  const ToastProgressBarWidget({
    super.key,
    required this.animation,
    required this.toastStyle,
    required this.toastSetting,
  });
  final Animation<double> animation;
  final ToastStyle toastStyle;
  final SlidingToastSetting toastSetting;

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
