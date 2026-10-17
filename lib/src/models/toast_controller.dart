import 'package:flutter/widgets.dart';

@immutable
class const ToastController({
  required final String id,
  required final VoidCallback closeToast,
}) {
  factory empty() => ToastController(id: '', closeToast: () {});

  @override
  String toString() => 'ToastController(id: $id, closeToast: $closeToast)';
}
