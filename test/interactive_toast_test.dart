import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('slide shows the toast via the overlay and can be closed', (
    tester,
  ) async {
    late BuildContext capturedContext;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            capturedContext = context;
            return const SizedBox();
          },
        ),
      ),
    );

    final controller = InteractiveToast.slide(
      context: capturedContext,
      title: const Text('hello'),
      toastSetting: const SlidingToastSetting(showProgressBar: false),
    );
    await tester.pump();

    expect(controller.id, isNotEmpty);
    expect(find.text('hello'), findsOneWidget);

    controller.closeToast();
    await tester.pump();

    expect(find.text('hello'), findsNothing);
  });

  testWidgets(
    'returns an empty controller when neither a mounted context nor an '
    'overlay is available',
    (tester) async {
      late BuildContext capturedContext;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return const SizedBox();
            },
          ),
        ),
      );

      /// Unmount the tree so `capturedContext` is no longer mounted.
      await tester.pumpWidget(const SizedBox());

      final controller = InteractiveToast.slide(
        context: capturedContext,
        title: const Text('hello'),
      );

      expect(controller.id, isEmpty);
      expect(find.text('hello'), findsNothing);
    },
  );

  testWidgets('closeAllToast removes every active toast', (tester) async {
    late BuildContext capturedContext;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            capturedContext = context;
            return const SizedBox();
          },
        ),
      ),
    );

    InteractiveToast.slide(
      context: capturedContext,
      title: const Text('one'),
      toastSetting: const SlidingToastSetting(showProgressBar: false),
    );
    InteractiveToast.slide(
      context: capturedContext,
      title: const Text('two'),
      toastSetting: const SlidingToastSetting(showProgressBar: false),
    );
    await tester.pump();

    expect(find.text('one'), findsOneWidget);
    expect(find.text('two'), findsOneWidget);

    InteractiveToast.closeAllToast();
    await tester.pump();

    expect(find.text('one'), findsNothing);
    expect(find.text('two'), findsNothing);
  });
}
