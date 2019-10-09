import 'dart:convert';
import 'dart:ffi';

/// Represents a string (char*) in C memory.
class Utf8 extends Struct<Utf8> {
  @Uint8()
  int char;

  /// Allocates and stores the given Dart [String] as a [Pointer<Utf8>].
  static Pointer<Utf8> toUtf8(String str) {
    final ptr = Pointer<Utf8>.allocate(count: str.length + 1);
    final units = const Utf8Encoder().convert(str);
    units.asMap().forEach((i, unit) => ptr.elementAt(i).load<Utf8>().char = unit);
    ptr.elementAt(units.length).load<Utf8>().char = 0;
    return ptr;
  }

  /// Gets the Dart [String] representation of a [Pointer<Utf8>].
  static String fromUtf8(Pointer<Utf8> ptr) {
    final units = <int>[];
    var len = 0;
    for (;;) {
      final char = ptr.elementAt(len++).load<Utf8>().char;
      if (char == 0) {
        break;
      }
      units.add(char);
    }
    return const Utf8Decoder().convert(units);
  }
}