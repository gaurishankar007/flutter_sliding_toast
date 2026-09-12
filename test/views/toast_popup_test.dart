import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:flutter_sliding_toast/src/views/toast_popup.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  Widget buildPopup({
    required bool disableMultiTapping,
    VoidCallback? onTapped,
  }) {
    return MaterialApp(
      home: ToastPopup(
        toastController: ToastController.empty(),
        leading: null,
        title: const Text('hi'),
        trailing: null,
        toastSetting: PopupToastSetting(
          disableMultiTapping: disableMultiTapping,
        ),
        toastStyle: const ToastStyle(),
        onTapped: onTapped,
      ),
    );
  }

  testWidgets('invokes onTapped on every tap when disableMultiTapping is false', (
    tester,
  ) async {
    var tapCount = 0;
    await tester.pumpWidget(
      buildPopup(disableMultiTapping: false, onTapped: () => tapCount++),
    );
    // Let the fade/scale-in animation finish so the toast is on screen and
    // hit-testable before the display window ends.
    await tester.pump(const Duration(milliseconds: 500));

    await tester.tap(find.text('hi'));
    await tester.tap(find.text('hi'));

    expect(tapCount, 2);
  });

  testWidgets('invokes onTapped only once when disableMultiTapping is true', (
    tester,
  ) async {
    var tapCount = 0;
    await tester.pumpWidget(
      buildPopup(disableMultiTapping: true, onTapped: () => tapCount++),
    );
    await tester.pump(const Duration(milliseconds: 500));

    await tester.tap(find.text('hi'));
    await tester.tap(find.text('hi'));

    expect(tapCount, 1);
  });
}
