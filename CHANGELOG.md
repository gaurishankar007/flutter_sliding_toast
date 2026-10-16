## 1.7.0

- Added `ToastDisplayMode` to show toasts all at once (`allAtOnce`, the default and the previous behavior) or one by one (`oneByOne`), where a new toast waits in a queue until the one on screen is closed. Set it for every toast with `InteractiveToast.setDisplayMode`, or per toast with the `displayMode` parameter of `slide`/`pop`.
- Added `showDialogOnTap` to `SlidingToastSetting` and `PopupToastSetting` to show the whole toast content in a dialog styled like the toast when it's tapped, scrollable if the message is long. The toast is paused while the dialog is open. Customize the dialog with `dialogSetting` (`ToastDialogSetting`), and pass `dialogTitle` to `slide`/`pop` to show a different (e.g. untruncated) title in the dialog.
- `closeAllToast` also drops the toasts waiting in the queue.
- Fixed `closeToast` leaving the toast on screen when called before its first frame was built.

## 1.6.0

- Migrated from `package:flutter/material.dart` to the standalone `material_ui` package (Material and Cupertino were split out of the Flutter SDK in Flutter 3.47). Only the files that actually need `Theme`/`Material`/`Colors`/`Icons` now depend on `material_ui`; everything else uses `package:flutter/widgets.dart`. Requires Flutter 3.47 or newer.
- Fixed a bug where a toast with `glassBlur` set was always fully transparent, since `backgroundColorOpacity` was multiplied by `.255` instead of `255` when computing the background alpha.
- Fixed `PopupToastSetting`'s default `animationDuration`, which was `Duration(microseconds: 500)` instead of `Duration(milliseconds: 500)`, making the fade/scale-in animation imperceptible.
- Fixed `slideError`/`popError`'s `disableMultiTapping` parameter, which was previously accepted but never applied.
- Added test coverage for the settings/style models, the toast widgets, and `InteractiveToast`.

## 1.5.3

- Bumped Dart SDK version and updated the lint rules.

## 1.5.2

- Added cross axis alignment for the leading, title, and trailing widgets which are aligned in a row.

## 1.5.1

- Fixed an issue where the toast container's maxHeight and maxWidth constraints were not being applied correctly.

## 1.5.0

- Either use context or provide an existing overlay state
- Initialize context or overlay state early for persistent toast availability
- Updated sdk version and depreciated methods

## 1.4.3

- Gradient color and decoration image added inside toast container

## 1.4.2

- Overflow inside toast container bug is solved

## 1.4.1

- Make the title width dynamic, by disabling progress bar and making 'expandedTitle' to false in toast style
- Enabling progress bar will make title expanded even if 'expandedTitle' is true

## 1.4.0

- Show popup toast with title, leading, and trailing widget
- Enable or disable fading and scaling effect or modify their behavior
- bug fixes

## 1.3.0

- Add Leading widget
- Add spacing between leading and title or title and trailing
- Close an individual or all displayed toasts programmatically

## 1.2.0

- Execute functions when the toast is tapped or disposed
- Disable multiple tapping to execute callback only one time
- Screenshots updated

## 1.1.1

- Screenshots updated

## 1.1.0

- Glassmorphism design
- Pause the animation with long press and release it to continue
- Clipping the progressbar with border radius

## 1.0.2

- padding inside toast message
- list of box shadow for toast message
- toast message minimum/maximum height and width changed

## 1.0.1

- changed dart sdk version
- readme updated

## 1.0.0

- initial release
