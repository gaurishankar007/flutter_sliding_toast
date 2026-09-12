import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:flutter_sliding_toast/src/widgets/toast_progress_bar_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  Future<void> pumpBar(
    WidgetTester tester, {
    required double progressBarHeight,
  }) {
    return tester.pumpWidget(
      MaterialApp(
        home: ToastProgressBarWidget(
          animation: const AlwaysStoppedAnimation<double>(1),
          toastStyle: const ToastStyle(),
          toastSetting: SlidingToastSetting(
            progressBarHeight: progressBarHeight,
          ),
        ),
      ),
    );
  }

  testWidgets('clamps a height below the minimum up to 2', (tester) async {
    await pumpBar(tester, progressBarHeight: 0.5);
    final box = tester.widget<SizedBox>(find.byType(SizedBox).first);
    expect(box.height, 2);
  });

  testWidgets('clamps a height above the maximum down to 8', (tester) async {
    await pumpBar(tester, progressBarHeight: 20);
    final box = tester.widget<SizedBox>(find.byType(SizedBox).first);
    expect(box.height, 8);
  });

  testWidgets('keeps an in-range height as-is', (tester) async {
    await pumpBar(tester, progressBarHeight: 4);
    final box = tester.widget<SizedBox>(find.byType(SizedBox).first);
    expect(box.height, 4);
  });
}
