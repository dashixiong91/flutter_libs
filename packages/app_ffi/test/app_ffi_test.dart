import 'package:flutter_test/flutter_test.dart';
import 'package:app_ffi/app_ffi.dart';
import 'utils.dart';

void main() {
  setUp(testSetUp);
  test('add method', () async {
    expect(add(1, 2), 3);
  });
}
