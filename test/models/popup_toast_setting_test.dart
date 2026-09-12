import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PopupToastSetting', () {
    test('default animationDuration is 500 milliseconds', () {
      const setting = PopupToastSetting();

      /// Regression test: this was previously `Duration(microseconds: 500)`,
      /// which made the fade/scale-in animation imperceptible.
      expect(setting.animationDuration, const Duration(milliseconds: 500));
    });

    test('copyWith overrides only the given fields', () {
      const setting = PopupToastSetting();
      final updated = setting.copyWith(
        displayDuration: const Duration(seconds: 5),
        showFading: false,
      );

      expect(updated.displayDuration, const Duration(seconds: 5));
      expect(updated.showFading, isFalse);
      expect(updated.animationDuration, setting.animationDuration);
      expect(updated.showScaling, setting.showScaling);
      expect(updated.toastAlignment, setting.toastAlignment);
    });
  });
}
