import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sliding Toast Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Sliding Toast",
          style: TextStyle(color: Colors.white),
        ),
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
                    "Hi there! I'm a simple toast 😎. Dismiss me by sliding downward.",
                    style: TextStyle(),
                  ),
                  trailing: const Icon(Icons.person, color: Colors.deepPurple),
                  toastSetting: const ToastSetting(
                    animationDuration: Duration(seconds: 1),
                    displayDuration: Duration(seconds: 2),
                    toastStartPosition: ToastPosition.bottom,
                    toastAlignment: Alignment.bottomCenter,
                  ),
                );
              },
              child: const Text("Show Toast From Bottom"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                SlidingToast.show(
                  context,
                  title: const Text(
                    "Hi there! I'm a simple toast 😎. Dismiss me by sliding upward.",
                    style: TextStyle(),
                  ),
                  trailing: const Icon(Icons.person, color: Colors.deepPurple),
                  toastSetting: const ToastSetting(
                    animationDuration: Duration(seconds: 1),
                    displayDuration: Duration(seconds: 2),
                    toastStartPosition: ToastPosition.top,
                    toastAlignment: Alignment.topCenter,
                  ),
                );
              },
              child: const Text("Show Toast From Top"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                SlidingToast.showError(
                  context,
                  title: const Text(
                    "Hi there! I'm a error toast 😈",
                    style: TextStyle(),
                  ),
                  toastSetting: const ToastSetting(
                    toastStartPosition: ToastPosition.left,
                    toastAlignment: Alignment.bottomLeft,
                  ),
                );
              },
              child: const Text("Show Error Toast From Bottom Left"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                SlidingToast.showSuccess(
                  context,
                  title: const Text(
                    "Hi there! I'm a success toast 😎",
                    style: TextStyle(),
                  ),
                  toastSetting: const ToastSetting(
                    toastStartPosition: ToastPosition.right,
                    toastAlignment: Alignment.topRight,
                  ),
                );
              },
              child: const Text("Show Success Toast From Top Right"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                SlidingToast.show(
                  context,
                  title: const Text(
                    "Hi there! I'm modified toast 😎 with only title widget "
                    "and display duration of 5 seconds. "
                    "Modification is done to my styles. Check out the code for more details.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  toastSetting: const ToastSetting(
                    maxHeight: 140,
                    animationDuration: Duration(seconds: 1),
                    displayDuration: Duration(seconds: 5),
                    showReverseAnimation: false,
                    showProgressBar: false,
                    toastStartPosition: ToastPosition.left,
                    toastAlignment: Alignment.center,
                  ),
                  toastStyle: ToastStyle(
                    backgroundColor: Colors.blueAccent,
                    boxShadow: BoxShadow(
                      color: Colors.blue.withOpacity(.2),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ),
                );
              },
              child: const Text("Show Modified Toast From Center"),
            ),
          ],
        ),
      ),
    );
  }
}
