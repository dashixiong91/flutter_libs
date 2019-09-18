import 'package:flutter_test/flutter_test.dart';
import 'package:app_ffi/app_ffi.dart' as appFfi;

void main() {
  setUp(() {
    // TODO: mock load dy lib
    appFfi.init();
  });
  test('add method', () async {
    expect(appFfi.add(1, 2), 3);
  });
}
