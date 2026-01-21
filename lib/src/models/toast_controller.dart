import 'package:flutter/material.dart';

@immutable
class ToastController {
  const ToastController({required this.id, required this.closeToast});

  factory ToastController.empty() => ToastController(id: '', closeToast: () {});

  final String id;
  final VoidCallback closeToast;

  @override
  String toString() => 'ToastController(id: $id, closeToast: $closeToast)';
}
