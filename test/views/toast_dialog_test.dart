import 'dart:async';

import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:flutter_sliding_toast/src/views/toast_dialog.dart';
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

  tearDown(InteractiveToast.closeAllToast);

  testWidgets('tapping a slide toast shows the dialog with dialogTitle', (
    tester,
  ) async {
    await pumpApp(tester);
    var tapCount = 0;

    InteractiveToast.slide(
      context: capturedContext,
      title: const Text('short'),
      dialogTitle: const Text('the whole long message'),
      toastSetting: const SlidingToastSetting(
        showProgressBar: false,
        showDialogOnTap: true,
      ),
      onTapped: () => tapCount++,
    );
    // The first frame builds the toast and starts its animation.
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.text('short'));
    await tester.pumpAndSettle();

    expect(tapCount, 1);
    expect(find.byType(ToastDialog), findsOneWidget);
    expect(find.text('the whole long message'), findsOneWidget);

    // The toast is paused while the dialog is open.
    await tester.pump(const Duration(seconds: 5));
    expect(find.text('short'), findsOneWidget);

    // Closing the dialog resumes the toast.
    await tester.tapAt(const Offset(5, 5));
    await tester.pumpAndSettle();
    expect(find.byType(ToastDialog), findsNothing);
    expect(find.text('short'), findsNothing);
  });

  testWidgets('tapping a popup toast shows the dialog with its title', (
    tester,
  ) async {
    await pumpApp(tester);

    InteractiveToast.pop(
      context: capturedContext,
      title: const Text('popup'),
      toastSetting: const PopupToastSetting(showDialogOnTap: true),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    await tester.tap(find.text('popup'));
    await tester.pumpAndSettle();

    expect(find.byType(ToastDialog), findsOneWidget);
    expect(find.text('popup'), findsNWidgets(2));
  });

  testWidgets('no dialog is shown when showDialogOnTap is false', (
    tester,
  ) async {
    await pumpApp(tester);

    InteractiveToast.slide(
      context: capturedContext,
      title: const Text('short'),
      toastSetting: const SlidingToastSetting(showProgressBar: false),
    );
    // The first frame builds the toast and starts its animation.
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.text('short'));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byType(ToastDialog), findsNothing);
  });

  testWidgets('a long dialog message scrolls instead of overflowing', (
    tester,
  ) async {
    await pumpApp(tester);

    // Not awaited, since it completes only when the dialog is closed.
    unawaited(
      showToastDialog(
        capturedContext,
        leading: const Icon(Icons.info),
        title: Text('long message ' * 500),
        trailing: null,
        toastStyle: const ToastStyle(),
        dialogSetting: const ToastDialogSetting(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ToastDialog), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
