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

class MyHomePage extends StatelessWidget {
  final VoidCallback changeColor;
  const MyHomePage({super.key, required this.changeColor});

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
                SlidingToast.show(
                  context,
                  title: const Text(
                    "Hi there! I'm a simple toast 😎."
                    " Dismiss me by sliding downward.",
                  ),
                  trailing: const TrailingWidget(),
                  toastSetting: const ToastSetting(
                    animationDuration: Duration(seconds: 1),
                    displayDuration: Duration(seconds: 2),
                    toastStartPosition: ToastPosition.bottom,
                    toastAlignment: Alignment.bottomCenter,
                  ),
                );
              },
              child: const Text(
                "Toast from bottom center",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                SlidingToast.show(
                  context,
                  title: const Text(
                    "Hi there! I'm a glassy toast 🦄."
                    "Dismiss me by sliding upward.",
                  ),
                  trailing: const TrailingWidget(),
                  toastSetting: const ToastSetting(
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
              child: const Text(
                "Glassy toast from top center",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                SlidingToast.showError(
                  context,
                  title: const Text(
                    "Hi there! I'm a error toast 😈. "
                    "Dismiss me by sliding horizontally.",
                  ),
                  toastSetting: const ToastSetting(
                    toastStartPosition: ToastPosition.left,
                    toastAlignment: Alignment.bottomLeft,
                    displayDuration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text(
                "Error toast from bottom left",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                SlidingToast.showSuccess(
                  context,
                  title: const Text(
                    "Hi there! I'm a success toast 🦁",
                  ),
                  toastSetting: const ToastSetting(
                    toastStartPosition: ToastPosition.right,
                    toastAlignment: Alignment.topRight,
                  ),
                );
              },
              child: const Text(
                "Success toast from Top Right",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                SlidingToast.show(
                  context,
                  title: const Text(
                    "Hi there! I'm modified toast 🐷 with only title widget "
                    "and display duration of 4 seconds. "
                    " Check out the code for more details.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  toastSetting: const ToastSetting(
                    maxHeight: 140,
                    animationDuration: Duration(seconds: 3),
                    displayDuration: Duration(seconds: 4),
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
              child: const Text(
                "Modified toast from center left",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                SlidingToast.show(
                  context,
                  title: const Text(
                    "Hi there! I'm a callback toast 🐺."
                    "Tap me to change theme color.",
                  ),
                  trailing: const TrailingWidget(),
                  toastSetting: const ToastSetting(
                    animationDuration: Duration(seconds: 1),
                    displayDuration: Duration(seconds: 4),
                    toastStartPosition: ToastPosition.bottom,
                    toastAlignment: Alignment.bottomCenter,
                  ),
                  onTapped: changeColor,
                );
              },
              child: const Text(
                "Callback toast",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
