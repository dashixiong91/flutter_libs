import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_ffi/app_ffi.dart';

void main() {
  const MethodChannel channel = MethodChannel('app_ffi');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await AppFfi.platformVersion, '42');
  });
}
