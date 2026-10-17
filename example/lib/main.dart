import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const MyApp());
}

class const MyApp({super.key}) extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool colorChanged = false;
  Color color = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sliding Toast Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: color),
        appBarTheme: AppBarTheme(
          backgroundColor: color,
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: MyHomePage(changeColor: changeColor),
    );
  }

  void changeColor() => setState(() {
    colorChanged ? color = Colors.deepPurple : color = Colors.green;
    colorChanged = !colorChanged;
  });
}

class const MyHomePage({super.key, required final VoidCallback changeColor})
    extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showOneByOne = InteractiveToast.displayMode == .oneByOne;

  @override
  void initState() {
    super.initState();

    /// Setup overlay state when the UI build is finished.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      InteractiveToast.initializeOverlayState(Overlay.of(context));
      // Or setup context
      // InteractiveToast.setupContext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Sliding & Popup Toast'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const .symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              const SizedBox(width: double.maxFinite),
              SwitchListTile(
                title: _textWidget('Show toasts one by one'),
                subtitle: const Text(
                  'Off: every toast shows at once. '
                  'On: toasts wait in a queue for their turn.',
                ),
                value: showOneByOne,
                onChanged: (value) {
                  setState(() => showOneByOne = value);
                  InteractiveToast.setDisplayMode(
                    value ? .oneByOne : .allAtOnce,
                  );
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _showThreeToasts,
                child: _textWidget('Show three toasts'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showLongMessageToast,
                child: _textWidget('Long message toast, tap to read it all'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  InteractiveToast.slide(
                    context: context,
                    leading: _leadingWidget(),
                    title: const Text(
                      "Hi there! I'm a simple toast 😎."
                      ' Dismiss me by sliding downward.',
                    ),
                    trailing: _trailingWidget(),
                    toastStyle: const ToastStyle(titleLeadingGap: 10),
                    toastSetting: const SlidingToastSetting(
                      displayDuration: Duration(seconds: 2),
                    ),
                  );
                },
                child: _textWidget('Toast from bottom center'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  InteractiveToast.slide(
                    context: context,
                    title: const Text(
                      "Hi there! I'm a glassy toast 🦄."
                      'Dismiss me by sliding upward.',
                    ),
                    trailing: _trailingWidget(),
                    toastSetting: const SlidingToastSetting(
                      displayDuration: Duration(seconds: 2),
                      toastStartPosition: .top,
                      toastAlignment: .topCenter,
                      progressBarHeight: 4,
                    ),
                    toastStyle: const ToastStyle(
                      glassBlur: 4,
                      backgroundColorOpacity: .3,
                    ),
                  );
                },
                child: _textWidget('Glassy toast from top center'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final overlayState = Overlay.of(context);
                  InteractiveToast.slide(
                    overlayState: overlayState,
                    title: const Text(
                      "Hi there! I'm a error toast 😈. "
                      'Dismiss me by sliding horizontally.',
                    ),
                    toastSetting: const SlidingToastSetting(
                      toastStartPosition: .left,
                      toastAlignment: .bottomLeft,
                      displayDuration: Duration(seconds: 2),
                    ),
                    trailing: const Icon(
                      Icons.warning_rounded,
                      color: Colors.red,
                    ),
                    toastStyle: ToastStyle(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withAlpha(25),
                          blurRadius: 5,
                          spreadRadius: 3,
                          offset: const Offset(2, 2),
                        ),
                      ],
                      progressBarColor: Colors.red,
                    ),
                  );
                },
                child: _textWidget('Error toast from bottom left'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  InteractiveToast.slide(
                    title: const Text("Hi there! I'm a success toast 🦁"),
                    toastSetting: const SlidingToastSetting(
                      toastStartPosition: .right,
                      toastAlignment: .topRight,
                    ),
                    trailing: const Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                    ),
                    toastStyle: ToastStyle(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withAlpha(38),
                          blurRadius: 5,
                          spreadRadius: 3,
                          offset: const Offset(2, 2),
                        ),
                      ],
                      progressBarColor: Colors.green,
                    ),
                  );
                },
                child: _textWidget('Success toast from Top Right'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  InteractiveToast.slide(
                    title: const Text(
                      "I'm a bit more modified toast 🐷 with only title widget, "
                      'without progressBar and reverse animation.',
                      textAlign: .center,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    toastSetting: const SlidingToastSetting(
                      maxHeight: 140,
                      animationDuration: Duration(seconds: 2),
                      displayDuration: Duration(seconds: 3),
                      showReverseAnimation: false,
                      showProgressBar: false,
                      toastStartPosition: .left,
                      toastAlignment: .center,
                    ),
                    toastStyle: ToastStyle(
                      image: const DecorationImage(
                        image: AssetImage('assets/image.jpg'),
                        fit: .cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withAlpha(51),
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  );
                },
                child: _textWidget('Decorated toast from center left'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  InteractiveToast.pop(
                    title: const Text(
                      "Hi! I'm a popup toast with onTap callback 🐺."
                      'Tap me to change theme color.',
                    ),
                    trailing: _trailingWidget(),
                    toastSetting: const PopupToastSetting(
                      animationDuration: Duration(seconds: 1),
                      displayDuration: Duration(seconds: 3),
                    ),
                    onTapped: widget.changeColor,
                  );
                },
                child: _textWidget('Callback toast at bottom'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  InteractiveToast.pop(
                    context: context,
                    title: const Text(
                      "Hello! I'm a popup toast 🤡 with no fading and scaling.",
                    ),
                    trailing: _trailingWidget(),
                    toastSetting: const PopupToastSetting(
                      showFading: false,
                      showScaling: false,
                      animationDuration: Duration(seconds: 1),
                      displayDuration: Duration(seconds: 3),
                      toastAlignment: .topRight,
                    ),
                  );
                },
                child: _textWidget('Popup toast at top right'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  InteractiveToast.pop(
                    title: const Text(
                      'Title is not expanded.',
                      style: TextStyle(color: Colors.white),
                    ),
                    toastSetting: const PopupToastSetting(
                      showFading: false,
                      showScaling: false,
                      animationDuration: Duration(seconds: 2),
                      displayDuration: Duration(seconds: 3),
                      toastAlignment: .center,
                    ),
                    toastStyle: const ToastStyle(
                      expandedTitle: false,
                      gradient: LinearGradient(
                        colors: [Colors.purple, Color(0xFF03589E)],
                      ),
                    ),
                  );
                },
                child: _textWidget('Small gradient toast at center'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: InteractiveToast.closeAllToast,
                child: _textWidget('Close all toast'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Shows three toasts at the same spot, stacking on each other
  /// or waiting for their turn depending on the display mode.
  void _showThreeToasts() {
    const colors = [Colors.deepPurple, Colors.teal, Colors.orange];
    for (var i = 0; i < colors.length; i++) {
      InteractiveToast.slide(
        title: Text(
          "I'm toast number ${i + 1} 🍞",
          style: const TextStyle(color: Colors.white),
        ),
        leading: const Icon(Icons.notifications, color: Colors.white),
        toastSetting: const SlidingToastSetting(
          displayDuration: Duration(milliseconds: 1500),
          toastStartPosition: .top,
          toastAlignment: .topCenter,
        ),
        toastStyle: ToastStyle(
          backgroundColor: colors[i],
          progressBarColor: Colors.white,
        ),
      );
    }
  }

  /// Shows a toast with a long message cut short,
  /// tapping it shows the whole message in a dialog.
  void _showLongMessageToast() {
    const message =
        "Hi there! I'm a toast with a long message 📜. "
        'A toast only has room for a line or two, so the rest of this '
        'message is cut short. Tap me to read the whole message in a '
        'dialog styled just like me. The toast is paused while the dialog '
        'is open and continues once the dialog is closed. If the message '
        'is longer than the dialog, it scrolls, so even a really long '
        'error report or release note can be read in full without leaving '
        'the screen you are on.';
    const textStyle = TextStyle(color: Colors.white);

    InteractiveToast.slide(
      leading: const Icon(Icons.article_rounded, color: Colors.white),
      title: const Text(
        message,
        maxLines: 2,
        overflow: .ellipsis,
        style: textStyle,
      ),
      dialogTitle: const Text(message, style: textStyle),
      toastSetting: const SlidingToastSetting(
        displayDuration: Duration(seconds: 4),
        showDialogOnTap: true,
        dialogSetting: ToastDialogSetting(maxHeight: 300),
      ),
      toastStyle: const ToastStyle(
        backgroundColor: Color(0xFF263238),
        progressBarColor: Colors.amber,
        titleLeadingGap: 10,
        widgetCrossAxisAlignment: .start,
      ),
    );
  }

  Container _leadingWidget() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: .circle,
        color: Colors.purple,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            spreadRadius: 3,
            blurRadius: 4,
          ),
        ],
      ),
      alignment: .center,
      child: const Text('🦄', style: TextStyle(fontSize: 20)),
    );
  }

  Text _textWidget(String text) =>
      Text(text, style: const TextStyle(fontSize: 16));

  Icon _trailingWidget() =>
      Icon(Icons.person, color: Theme.of(context).colorScheme.primary);
}
