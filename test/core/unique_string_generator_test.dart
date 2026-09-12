import 'package:flutter_sliding_toast/src/core/unique_string_generator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('getUniqueString returns distinct, increasing ids', () {
    final first = getUniqueString();
    final second = getUniqueString();
    final third = getUniqueString();

    expect({first, second, third}, hasLength(3));
    expect(int.parse(second), greaterThan(int.parse(first)));
    expect(int.parse(third), greaterThan(int.parse(second)));
  });
}
