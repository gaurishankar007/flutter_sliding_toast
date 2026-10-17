import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:flutter_sliding_toast/src/widgets/toast_container_widget.dart';
import 'package:material_ui/material_ui.dart';

/// Shows the toast content in a dialog styled like the toast,
/// with the [title] scrollable if it's too long.
///
/// Completes when the dialog is closed, or right away if
/// there is no [Navigator] above [context] to show it in.
Future<void> showToastDialog(
  BuildContext context, {
  required Widget? leading,
  required Widget title,
  required Widget? trailing,
  required ToastStyle toastStyle,
  required ToastDialogSetting dialogSetting,
  double? toastMaxWidth,
}) async {
  final navigator = Navigator.maybeOf(context, rootNavigator: true);
  if (navigator == null) {
    return;
  }

  await navigator.push(
    RawDialogRoute<void>(
      barrierColor: dialogSetting.barrierColor,
      barrierDismissible: dialogSetting.barrierDismissible,
      barrierLabel: 'Dismiss',
      transitionDuration: dialogSetting.animationDuration,
      pageBuilder: (context, animation, secondaryAnimation) => ToastDialog(
        leading: leading,
        title: title,
        trailing: trailing,
        toastStyle: toastStyle,
        dialogSetting: dialogSetting,
        toastMaxWidth: toastMaxWidth,
      ),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        );
        return FadeTransition(
          opacity: curvedAnimation,
          child: ScaleTransition(
            scale: Tween<double>(begin: .9, end: 1).animate(curvedAnimation),
            child: child,
          ),
        );
      },
    ),
  );
}

/// A dialog displaying the whole toast content
class const ToastDialog({
  super.key,

  /// The widget to display at the start of the message
  required final Widget? leading,

  /// The message to display, scrollable if it's too long
  required final Widget title,

  /// The widget to display at the end of the message
  required final Widget? trailing,

  /// The style of the toast, reused for the dialog
  required final ToastStyle toastStyle,

  /// The setting for the dialog
  required final ToastDialogSetting dialogSetting,

  /// The toast's max width, used if the dialog's max width isn't given
  final double? toastMaxWidth,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    Widget child = ToastContainerWidget(
      leading: leading,
      title: SingleChildScrollView(child: title),
      trailing: trailing,
      toastStyle: toastStyle,
      expandTitleWidth: true,
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

    return SafeArea(
      child: Center(
        child: Padding(
          padding: dialogSetting.padding,
          // Material for the same text style and ink as the toast
          child: Material(
            color: Colors.transparent,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth:
                    dialogSetting.maxWidth ?? toastMaxWidth ?? size.width * .8,
                maxHeight: dialogSetting.maxHeight ?? size.height * .6,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
