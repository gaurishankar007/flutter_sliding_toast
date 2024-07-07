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
        colorScheme: ColorScheme.fromSeed(
          seedColor: color,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: color,
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: MyHomePage(changeColor: changeColor),
    );
  }

  changeColor() => setState(() {
        colorChanged ? color = Colors.deepPurple : color = Colors.green;
        colorChanged = !colorChanged;
      });
}

class MyHomePage extends StatefulWidget {
  final VoidCallback changeColor;
  const MyHomePage({super.key, required this.changeColor});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Sliding Toast"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: double.maxFinite),
            ElevatedButton(
              onPressed: () {
                InteractiveToast.slide(
                  context,
                  leading: leadingWidget(),
                  title: const Text(
                    "Hi there! I'm a simple toast 😎."
                    " Dismiss me by sliding downward.",
                  ),
                  trailing: const TrailingWidget(),
                  toastStyle: const ToastStyle(titleLeadingGap: 10),
                  toastSetting: const SlidingToastSetting(
                    animationDuration: Duration(seconds: 1),
                    displayDuration: Duration(seconds: 2),
                    toastAlignment: Alignment.bottomCenter,
                  ),
                );
              },
              child: textWidget("Toast from bottom center"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                InteractiveToast.slide(
                  context,
                  title: const Text(
                    "Hi there! I'm a glassy toast 🦄."
                    "Dismiss me by sliding upward.",
                  ),
                  trailing: const TrailingWidget(),
                  toastSetting: const SlidingToastSetting(
                    animationDuration: Duration(seconds: 1),
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
              child: textWidget("Glassy toast from top center"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                InteractiveToast.slideError(
                  context,
                  title: const Text(
                    "Hi there! I'm a error toast 😈. "
                    "Dismiss me by sliding horizontally.",
                  ),
                  toastSetting: const SlidingToastSetting(
                    toastStartPosition: ToastPosition.left,
                    toastAlignment: Alignment.bottomLeft,
                    displayDuration: Duration(seconds: 2),
                  ),
                );
              },
              child: textWidget("Error toast from bottom left"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                InteractiveToast.slideSuccess(
                  context,
                  title: const Text(
                    "Hi there! I'm a success toast 🦁",
                  ),
                  toastSetting: const SlidingToastSetting(
                    toastStartPosition: ToastPosition.right,
                    toastAlignment: Alignment.topRight,
                  ),
                );
              },
              child: textWidget("Success toast from Top Right"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                InteractiveToast.slide(
                  context,
                  title: const Text(
                    "I'm a bit more modified toast 🐷 with only title widget, "
                    "without progressBar and reverse animation.",
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
                    backgroundColor: Colors.blue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(.2),
                        blurRadius: 5,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                );
              },
              child: textWidget("Modified toast from center left"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                InteractiveToast.pop(
                  context,
                  title: const Text(
                    "Hi! I'm a popup toast with onTap callback 🐺."
                    "Tap me to change theme color.",
                  ),
                  trailing: const TrailingWidget(),
                  toastSetting: const PopupToastSetting(
                    animationDuration: Duration(seconds: 1),
                    displayDuration: Duration(seconds: 3),
                    toastAlignment: Alignment.bottomCenter,
                  ),
                  onTapped: widget.changeColor,
                );
              },
              child: textWidget("Callback toast at bottom"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                InteractiveToast.pop(
                  context,
                  title: const Text(
                    "Hello! I'm a popup toast 🤡 with no fading and scaling.",
                  ),
                  trailing: const TrailingWidget(),
                  toastSetting: const PopupToastSetting(
                    showFading: false,
                    showScaling: false,
                    animationDuration: Duration(seconds: 1),
                    displayDuration: Duration(seconds: 3),
                    toastAlignment: Alignment.topRight,
                  ),
                );
              },
              child: textWidget("Popup toast at top right"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: InteractiveToast.closeAllToast,
              child: textWidget("Close all toast"),
            ),
          ],
        ),
      ),
    );
  }

  Container leadingWidget() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.purple,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            spreadRadius: 3,
            blurRadius: 4,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Text(
        "🦄",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Text textWidget(String text) => Text(
        text,
        style: const TextStyle(fontSize: 16),
      );
}

class TrailingWidget extends StatelessWidget {
  const TrailingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.person,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
