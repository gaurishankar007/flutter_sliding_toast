import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  late BuildContext capturedContext;

  Future<void> pumpApp(WidgetTester tester) => tester.pumpWidget(
    MaterialApp(
      home: Builder(
        builder: (context) {
          capturedContext = context;
          return const SizedBox();
        },
      ),
    ),
  );

  ToastController slide(String text, {ToastDisplayMode? displayMode}) =>
      InteractiveToast.slide(
        context: capturedContext,
        title: Text(text),
        displayMode: displayMode,
        toastSetting: const SlidingToastSetting(showProgressBar: false),
      );

  tearDown(() {
    InteractiveToast.closeAllToast();
    InteractiveToast.setDisplayMode(.allAtOnce);
  });

  test('defaults to showing all toasts at once', () {
    expect(InteractiveToast.displayMode, ToastDisplayMode.allAtOnce);
  });

  testWidgets('allAtOnce shows every toast right away', (tester) async {
    await pumpApp(tester);

    slide('one');
    slide('two');
    await tester.pump();

    expect(find.text('one'), findsOneWidget);
    expect(find.text('two'), findsOneWidget);
  });

  testWidgets('oneByOne shows the next toast once the shown one closes', (
    tester,
  ) async {
    await pumpApp(tester);
    InteractiveToast.setDisplayMode(.oneByOne);

    final first = slide('one');
    final second = slide('two');
    slide('three');
    await tester.pump();

    expect(first.id, isNotEmpty);
    expect(second.id, isNotEmpty);
    expect(find.text('one'), findsOneWidget);
    expect(find.text('two'), findsNothing);

    first.closeToast();
    await tester.pump();

    expect(find.text('one'), findsNothing);
    expect(find.text('two'), findsOneWidget);
    expect(find.text('three'), findsNothing);
  });

  testWidgets('oneByOne moves on after the shown toast times out', (
    tester,
  ) async {
    await pumpApp(tester);
    InteractiveToast.setDisplayMode(.oneByOne);

    slide('one');
    slide('two');
    await tester.pump();
    expect(find.text('two'), findsNothing);

    // Slide in (1s), display (1s), and slide out (1s) of the first toast.
    await tester.pump(const Duration(milliseconds: 2500));
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pump();

    expect(find.text('one'), findsNothing);
    expect(find.text('two'), findsOneWidget);
  });

  testWidgets('closing a queued toast removes it from the queue', (
    tester,
  ) async {
    await pumpApp(tester);
    InteractiveToast.setDisplayMode(.oneByOne);

    final first = slide('one');
    slide('two').closeToast();
    slide('three');
    await tester.pump();

    first.closeToast();
    await tester.pump();

    expect(find.text('two'), findsNothing);
    expect(find.text('three'), findsOneWidget);
  });

  testWidgets('a per-call display mode overrides the global one', (
    tester,
  ) async {
    await pumpApp(tester);

    slide('one', displayMode: .oneByOne);
    slide('two', displayMode: .oneByOne);
    slide('three');
    await tester.pump();

    expect(find.text('one'), findsOneWidget);
    expect(find.text('two'), findsNothing);
    expect(find.text('three'), findsOneWidget);
  });

  testWidgets('closeAllToast also drops the queued toasts', (tester) async {
    await pumpApp(tester);
    InteractiveToast.setDisplayMode(.oneByOne);

    slide('one');
    slide('two');
    await tester.pump();

    InteractiveToast.closeAllToast();
    await tester.pump();

    expect(find.text('one'), findsNothing);
    expect(find.text('two'), findsNothing);

    // The queue is free again.
    slide('three');
    await tester.pump();
    expect(find.text('three'), findsOneWidget);
  });
}
