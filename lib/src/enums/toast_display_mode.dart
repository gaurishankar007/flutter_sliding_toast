/// How toasts behave when a new one is shown while others are on screen.
enum ToastDisplayMode {
  /// Every toast is shown right away, stacking on the ones already on screen.
  allAtOnce,

  /// Toasts are shown one at a time, the next one waiting in a queue
  /// until the one on screen is closed.
  oneByOne,
}
