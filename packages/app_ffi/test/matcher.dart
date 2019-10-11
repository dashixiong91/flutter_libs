import 'package:app_ffi/src/utils/ffi.dart' as ffi_help;
import 'package:flutter_test/flutter_test.dart';

Matcher isNullPointer =IsNullPointer();
Matcher isNotNullPointer =IsNotNullPointer();

class IsNullPointer extends Matcher {
  const IsNullPointer();
  @override
  bool matches(item, Map matchState) => ffi_help.isNullPointer(item);
  @override
  Description describe(Description description) => description.add('null pointer');
}
class IsNotNullPointer extends Matcher {
  const IsNotNullPointer();
  @override
  bool matches(item, Map matchState) => ffi_help.isNotNullPointer(item);
  @override
  Description describe(Description description) => description.add('not null pointer');
}
