# Flutter Sliding Toast

<div>
  <a href="https://pub.dev/packages/flutter_sliding_toast"><img src="https://img.shields.io/pub/v/flutter_sliding_toast.svg" alt="pub"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="license: MIT"></a>
</div>

---

A flutter sliding toast for displaying beautiful messages.

## Breaking Changes

The 1.3.0 version brings some breaking changes.

- 'disableMultiTapping' moved to toast settings from the SlidingToast's 'show' function.

## 🎨 Screenshot

<div display="flex" flex-wrap="wrap" align="center">
  <img src="https://res.cloudinary.com/gaurishankar/image/upload/v1719663894/Flutter%20Sliding%20Toast%20Pub%20Package/1_ihr98j.gif" width="30%">
  <img src="https://res.cloudinary.com/gaurishankar/image/upload/v1719663773/Flutter%20Sliding%20Toast%20Pub%20Package/2_dnl9vh.gif" width="30%">
  <img src="https://res.cloudinary.com/gaurishankar/image/upload/v1719663772/Flutter%20Sliding%20Toast%20Pub%20Package/3_dw6mh6.gif" width="30%">
  <img src="https://res.cloudinary.com/gaurishankar/image/upload/v1719663816/Flutter%20Sliding%20Toast%20Pub%20Package/4_wzchhp.gif" width="30%">
  <img src="https://res.cloudinary.com/gaurishankar/image/upload/v1719663776/Flutter%20Sliding%20Toast%20Pub%20Package/5_rzepq2.gif" width="30%">
  <img src="https://res.cloudinary.com/gaurishankar/image/upload/v1719663775/Flutter%20Sliding%20Toast%20Pub%20Package/6_ns4vcc.gif" width="30%">
</div>

## 🎯 Features

- Change toast's sliding directions and alignment positions
- Define sliding and display duration, max height and width, padding
- Set title, leading, trailing widgets and disable the progressbar
- Use glassmorphism design or default success and error toast
- Dismiss the toast by sliding it horizontally or vertically
- Dismiss an individual or all toasts programmatically
- Pause the animation with long press and release it to continue
- Execute a function after the toast is tapped or disposed
- Disable Multiple tapping to execute 'onTap' callback only one time

## ⚙️ Getting Started

Add the following line to `pubspec.yaml`:

```yaml
dependencies:
  flutter_sliding_toast: ^1.3.0
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
