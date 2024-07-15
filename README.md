# Flutter Sliding Toast

<div>
  <a href="https://pub.dev/packages/flutter_sliding_toast"><img src="https://img.shields.io/pub/v/flutter_sliding_toast.svg" alt="pub"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="license: MIT"></a>
</div>

---

A flutter sliding toast for displaying beautiful messages.

## Breaking Changes v1.4.0

The 1.4.0 version brings some breaking changes.

- 'SlidingToast' renamed to 'InteractiveToast' along with it's methods
  - 'show' renamed to 'slide'
  - 'showSuccess' renamed to 'slideSuccess'
  - 'showError' renamed to 'slideError'
- 'ToastSetting' renamed to 'SlidingToastSetting'
- 'disableMultiTapping' moved from 'show' ('slide' currently) function to 'ToastSetting' ('SlidingToastSetting' currently).

## 🎨 Screenshots

<div display="flex" flex-wrap="wrap" align="center">
  <img src="https://res.cloudinary.com/gaurishankar/image/upload/v1720411711/Flutter%20Sliding%20Toast%20Pub%20Package/mpajt61nkff1zzzkoynr.gif" width="30%">
  <img src="https://res.cloudinary.com/gaurishankar/image/upload/v1720411957/Flutter%20Sliding%20Toast%20Pub%20Package/u0rhkp2zr7xfqcuoyfdy.gif" width="30%">
  <img src="https://res.cloudinary.com/gaurishankar/image/upload/v1720411962/Flutter%20Sliding%20Toast%20Pub%20Package/fbqjeuu3pb4nlcuoonzj.gif" width="30%">
  <img src="https://res.cloudinary.com/gaurishankar/image/upload/v1720411713/Flutter%20Sliding%20Toast%20Pub%20Package/cz0ijfq7uzhtpiewopjf.gif" width="30%">
  <img src="https://res.cloudinary.com/gaurishankar/image/upload/v1720412052/Flutter%20Sliding%20Toast%20Pub%20Package/fuvrfgqdgou5ickj7w17.gif" width="30%">
  <img src="https://res.cloudinary.com/gaurishankar/image/upload/v1720411805/Flutter%20Sliding%20Toast%20Pub%20Package/iwumvethuwfldkxdlgwx.gif" width="30%">
  <img src="https://res.cloudinary.com/gaurishankar/image/upload/v1720411805/Flutter%20Sliding%20Toast%20Pub%20Package/i1l79zvmuyowwpxddfci.gif" width="30%">
  <img src="https://res.cloudinary.com/gaurishankar/image/upload/v1720412087/Flutter%20Sliding%20Toast%20Pub%20Package/hntbiuj13cwvmfcrkzvi.gif" width="30%">
</div>

## 🎯 Features

- Show sliding toasts, modify sliding behaviors
- Show popup toasts, disable or modify fading and scaling behaviors
- Change toast's alignment positions and sliding toast's sliding directions
- Define animation and display duration, max height and width, padding
- Set title, leading, trailing widgets and disable the progressbar in sliding toast
- Make title width dynamic or expanded
- Use glassmorphism design or default success and error toast
- Dismiss the sliding toast by sliding it horizontally or vertically
- Dismiss the popup toast by sliding it horizontally
- Dismiss an individual or all toasts programmatically
- Pause the animation with long press and release it to continue
- Execute a function after the toast is tapped or disposed
- Disable Multiple tapping to execute 'onTap' callback only one time

## ⚙️ Getting Started

Add the following line to `pubspec.yaml`:

```yaml
dependencies:
  flutter_sliding_toast: ^1.4.1
```

## 🚀 Usage

```dart
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Sliding & Popup Toast"),
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
                    "Hi there! I'm a sliding toast 😎. "
                    "Dismiss me by sliding upward.",
                  ),
                  trailing: trailingWidget(),
                  toastStyle: const ToastStyle(titleLeadingGap: 10),
                  toastSetting: const SlidingToastSetting(
                    animationDuration: Duration(seconds: 1),
                    displayDuration: Duration(seconds: 2),
                    toastStartPosition: ToastPosition.top,
                    toastAlignment: Alignment.topCenter,
                  ),
                );
              },
              child: textWidget("Sliding toast from top center"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                InteractiveToast.pop(
                  context,
                  title: const Text(
                    "Hi! I'm a popup toast 🐺. "
                    "I have fading and scaling effect.",
                  ),
                  trailing: trailingWidget(),
                  toastSetting: const PopupToastSetting(
                    animationDuration: Duration(seconds: 1),
                    displayDuration: Duration(seconds: 3),
                    toastAlignment: Alignment.bottomCenter,
                  ),
                );
              },
              child: textWidget("Popup toast at bottom center"),
            ),
          ],
        ),
      ),
    );
  }

  Text textWidget(String text) => Text(
        text,
        style: const TextStyle(fontSize: 16),
      );

  Icon trailingWidget() => const Icon(
        Icons.person,
        color: Colors.deepPurple,
      );

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
}
```

## ❤️ Additional information

Pull requests are welcomed!

If you encounter any problems or you have any ideas, feel free to open an issue:

- [Form for bugs](https://github.com/gaurishankar007/flutter_sliding_toast/issues/new?assignees=&labels=&projects=&template=bug_report.md&title=)
- [Form for feature requests](https://github.com/gaurishankar007/flutter_sliding_toast/issues/new?assignees=&labels=&projects=&template=feature_request.md&title=)
