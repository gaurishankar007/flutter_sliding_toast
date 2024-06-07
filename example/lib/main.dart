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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
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
        backgroundColor: Colors.deepPurpleAccent,
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
                  trailing:
                      const Icon(Icons.person, color: Colors.deepPurpleAccent),
                  toastSetting: const ToastSetting(
                    animationDuration: Duration(seconds: 1),
                    displayDuration: Duration(seconds: 2),
                    toastStartPosition: ToastPosition.bottom,
                    toastAlignment: Alignment.bottomCenter,
                  ),
                );
              },
              child: const Text("Toast from bottom center"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                SlidingToast.show(
                  context,
                  title: const Text(
                    "Hi there! I'm a glassy toast 😎. Dismiss me by sliding upward.",
                    style: TextStyle(),
                  ),
                  trailing: const Icon(Icons.person),
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
              child: const Text("Glassy toast from top center"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                SlidingToast.showError(
                  context,
                  title: const Text(
                    "Hi there! I'm a error toast 😈. Dismiss me by sliding horizontally.",
                    style: TextStyle(),
                  ),
                  toastSetting: const ToastSetting(
                    toastStartPosition: ToastPosition.left,
                    toastAlignment: Alignment.bottomLeft,
                    displayDuration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text("Error toast from bottom left"),
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
              child: const Text("Success toast from Top Right"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                SlidingToast.show(
                  context,
                  title: const Text(
                    "Hi there! I'm modified toast 😎 with only title widget "
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
                    backgroundColor: Colors.deepPurpleAccent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurpleAccent.withOpacity(.2),
                        blurRadius: 5,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                );
              },
              child: const Text("Modified toast from center left"),
            ),
          ],
        ),
      ),
    );
  }
}
