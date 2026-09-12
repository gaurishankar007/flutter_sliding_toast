import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:flutter_sliding_toast/src/views/toast_slider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  Widget buildSlider({
    required bool disableMultiTapping,
    VoidCallback? onTapped,
  }) {
    return MaterialApp(
      home: ToastSlider(
        toastController: ToastController.empty(),
        leading: null,
        title: const Text('hi'),
        trailing: null,
        toastSetting: SlidingToastSetting(
          showProgressBar: false,
          disableMultiTapping: disableMultiTapping,
        ),
        toastStyle: const ToastStyle(),
        onTapped: onTapped,
      ),
    );
  }

  testWidgets(
    'invokes onTapped on every tap when disableMultiTapping is false',
    (tester) async {
      var tapCount = 0;
      await tester.pumpWidget(
        buildSlider(disableMultiTapping: false, onTapped: () => tapCount++),
      );
      // Let the slide-in animation finish so the toast is on screen and
      // hit-testable before the display window ends.
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.text('hi'));
      await tester.tap(find.text('hi'));

      expect(tapCount, 2);
    },
  );

  testWidgets('invokes onTapped only once when disableMultiTapping is true', (
    tester,
  ) async {
    var tapCount = 0;
    await tester.pumpWidget(
      buildSlider(disableMultiTapping: true, onTapped: () => tapCount++),
    );
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.text('hi'));
    await tester.tap(find.text('hi'));

    expect(tapCount, 1);
  });
}
