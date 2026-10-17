import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SlidingToastSetting', () {
    test('default toastStartPosition is bottom', () {
      const setting = SlidingToastSetting();
      expect(setting.toastStartPosition, ToastPosition.bottom);
    });

    test('copyWith overrides only the given fields', () {
      const setting = SlidingToastSetting();
      final updated = setting.copyWith(
        toastStartPosition: .top,
        showProgressBar: false,
      );

      expect(updated.toastStartPosition, ToastPosition.top);
      expect(updated.showProgressBar, isFalse);
      expect(updated.curve, setting.curve);
      expect(updated.animationDuration, setting.animationDuration);
    });
  });
}
