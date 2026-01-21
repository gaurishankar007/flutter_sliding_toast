import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
        colorScheme: ColorScheme.fromSeed(seedColor: color),
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.changeColor});
  final VoidCallback changeColor;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: double.maxFinite),
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
                      toastStartPosition: ToastPosition.top,
                      toastAlignment: Alignment.topCenter,
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
                      toastStartPosition: ToastPosition.left,
                      toastAlignment: Alignment.bottomLeft,
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
                      toastStartPosition: ToastPosition.right,
                      toastAlignment: Alignment.topRight,
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
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    toastSetting: const SlidingToastSetting(
                      maxHeight: 140,
                      animationDuration: Duration(seconds: 2),
                      displayDuration: Duration(seconds: 3),
                      showReverseAnimation: false,
                      showProgressBar: false,
                      toastStartPosition: ToastPosition.left,
                      toastAlignment: Alignment.center,
                    ),
                    toastStyle: ToastStyle(
                      image: const DecorationImage(
                        image: AssetImage('assets/image.jpg'),
                        fit: BoxFit.cover,
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
                      toastAlignment: Alignment.topRight,
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
                      toastAlignment: Alignment.center,
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

  Container _leadingWidget() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.purple,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            spreadRadius: 3,
            blurRadius: 4,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Text('🦄', style: TextStyle(fontSize: 20)),
    );
  }

  Text _textWidget(String text) =>
      Text(text, style: const TextStyle(fontSize: 16));

  Icon _trailingWidget() =>
      Icon(Icons.person, color: Theme.of(context).colorScheme.primary);
}
