# Flutter Sliding Toast

<div>
    <a href="https://pub.dev/packages/flutter_sliding_toast"><img src="https://img.shields.io/pub/v/flutter_sliding_toast.svg" alt="pub"></a>
    <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="license: MIT"></a>
</div>

---

A flutter sliding toast for displaying message.

## 🎨 Screenshot

<div display="flex" flex-wrap="wrap" align="center">
  <img src="https://res.cloudinary.com/gaurishankar/image/upload/v1714452184/Flutter%20Sliding%20Toast%20Pub%20Package/mmfuxbwdewtqonsaunn1.gif" width="33%">
  <img src="https://res.cloudinary.com/gaurishankar/image/upload/v1714452182/Flutter%20Sliding%20Toast%20Pub%20Package/xi8o50mdm16ihgppceax.gif" width="33%">
  <img src="https://res.cloudinary.com/gaurishankar/image/upload/v1714452182/Flutter%20Sliding%20Toast%20Pub%20Package/xlcpmbrkuoebn7sf83am.gif" width="33%">
  <img src="https://res.cloudinary.com/gaurishankar/image/upload/v1714452183/Flutter%20Sliding%20Toast%20Pub%20Package/ulqjlzzfg1y4bkpowy3o.gif" width="33%">
  <img src="https://res.cloudinary.com/gaurishankar/image/upload/v1714452183/Flutter%20Sliding%20Toast%20Pub%20Package/jpcmxgppnqcdkycpt3mj.gif" width="33%">
</div>

## 🎯 Features

- Slide the toast from all direction
- Stick the toast at a position with alignment
- Define sliding and display duration
- Define max height and width
- Set padding inside the toast
- Set title and trailing widgets
- Disable the progressbar indicator
- Glassmorphism design
- Customize styles and animation behavior
- Use default success and error toast
- Dismiss the toast by sliding it horizontally or vertically
- Pause the animation by long pressing on the toast message
- Continue the animation by releasing the long press

## ⚙️ Getting Started

Add the following line to `pubspec.yaml`:

```yaml
dependencies:
  flutter_sliding_toast: ^1.1.0
```

## 🚀 Usage

```dart
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sliding Toast"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
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
            child: const Text("Show Toast"),
          ),
        ),
      ),
    );
  }
}
```

## ❤️ Additional information

Pull requests are welcomed!

If you encounter any problems or you have any ideas, feel free to open an issue:

- [Form for bugs](https://github.com/gaurishankar007/flutter_sliding_toast/issues/new?assignees=&labels=&projects=&template=bug_report.md&title=)
- [Form for feature requests](https://github.com/gaurishankar007/flutter_sliding_toast/issues/new?assignees=&labels=&projects=&template=feature_request.md&title=)
