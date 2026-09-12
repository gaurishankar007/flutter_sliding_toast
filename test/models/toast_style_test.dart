import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('ToastStyle', () {
    test('default backgroundColor is opaque white', () {
      const style = ToastStyle();
      expect(style.backgroundColor, const Color(0xFFFFFFFF));
    });

    test('copyWith overrides only the given fields', () {
      const style = ToastStyle();
      final updated = style.copyWith(
        backgroundColor: const Color(0xFF112233),
        expandedTitle: false,
      );

      expect(updated.backgroundColor, const Color(0xFF112233));
      expect(updated.expandedTitle, isFalse);
      expect(updated.borderRadius, style.borderRadius);
      expect(updated.titleLeadingGap, style.titleLeadingGap);
    });
  });
}
