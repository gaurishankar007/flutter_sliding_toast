import 'dart:math';

String getUniqueString() {
  final random = Random();
  final randomNumber = random.nextInt(10000000).toString();
  final timeStamp = DateTime.now().toIso8601String();

  return '$randomNumber$timeStamp';
}
