import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:flutter_sliding_toast/src/widgets/toast_container_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('applies backgroundColorOpacity to the background alpha when '
      'glassBlur is set', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ToastContainerWidget(
          leading: null,
          title: Text('hi'),
          trailing: null,
          expandTitleWidth: false,
          toastStyle: ToastStyle(
            backgroundColor: Color(0xFF112233),
            glassBlur: 5,
            backgroundColorOpacity: 0.5,
          ),
        ),
      ),
    );

    final container = tester.widget<Container>(find.byType(Container).first);
    final decoration = container.decoration! as BoxDecoration;

    /// Regression test: this previously multiplied the opacity by `.255`
    /// instead of `255`, which rounded the alpha down to 0 (fully
    /// invisible) no matter what opacity was requested.
    expect(decoration.color!.a, closeTo(0.5, 0.01));
  });

  testWidgets(
    'defaults to the fully opaque backgroundColor without glassBlur',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ToastContainerWidget(
            leading: null,
            title: Text('hi'),
            trailing: null,
            expandTitleWidth: false,
            toastStyle: ToastStyle(backgroundColor: Color(0xFF112233)),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).first);
      final decoration = container.decoration! as BoxDecoration;
      expect(decoration.color, const Color(0xFF112233));
    },
  );
}
