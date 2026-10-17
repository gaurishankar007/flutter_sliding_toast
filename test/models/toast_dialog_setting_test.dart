import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ToastDialogSetting', () {
    test('copyWith overrides only the given fields', () {
      const setting = ToastDialogSetting();
      final updated = setting.copyWith(
        maxHeight: 300,
        barrierDismissible: false,
      );

      expect(updated.maxHeight, 300);
      expect(updated.barrierDismissible, isFalse);
      expect(updated.barrierColor, setting.barrierColor);
      expect(updated.padding, setting.padding);
    });

    test('toast settings keep the dialog setting through copyWith', () {
      const dialogSetting = ToastDialogSetting(maxWidth: 200);
      final slide = const SlidingToastSetting(dialogSetting: dialogSetting)
          .copyWith(showDialogOnTap: true);
      final pop = const PopupToastSetting(dialogSetting: dialogSetting)
          .copyWith(showDialogOnTap: true);

      expect(slide.showDialogOnTap, isTrue);
      expect(slide.dialogSetting, dialogSetting);
      expect(pop.showDialogOnTap, isTrue);
      expect(pop.dialogSetting, dialogSetting);
    });
  });
}
