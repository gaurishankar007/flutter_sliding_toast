import 'package:flutter/material.dart';

@immutable
class ToastController {
  final String id;
  final VoidCallback closeToast;

  const ToastController({required this.id, required this.closeToast});

  factory ToastController.empty() => ToastController(id: "", closeToast: () {});

  @override
  String toString() => 'ToastController(id: $id, closeToast: $closeToast)';
}
