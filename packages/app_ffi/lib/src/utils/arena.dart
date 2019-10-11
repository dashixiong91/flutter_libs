// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:ffi' as ffi;

/// [Arena] manages allocated C memory.
///
/// Arenas are zoned.
class Arena {
  Arena();

  List<ffi.Pointer<ffi.Void>> _allocations = [];

  /// Bound the lifetime of [ptr] to this [Arena].
  T scoped<T extends ffi.Pointer>(T ptr) {
    _allocations.add(ptr.cast());
    return ptr;
  }

  /// Frees all memory pointed to by [Pointer]s in this arena.
  void finalize() {
    for (final ptr in _allocations) {
      ptr.free();
    }
  }

  /// The last [Arena] in the zone.
  factory Arena.current() {
    return Zone.current[#_currentArena];
  }
}

/// Bound the lifetime of [ptr] to the current [Arena].
T scoped<T extends ffi.Pointer>(T ptr) => Arena.current().scoped(ptr);

class RethrownError {
  dynamic original;
  StackTrace originalStackTrace;
  RethrownError(this.original, this.originalStackTrace);
  toString() => """RethrownError(${original})
${originalStackTrace}""";
}

/// Runs the [body] in an [Arena] freeing all memory which is [scoped] during
/// execution of [body] at the end of the execution.
R runArena<R>(R Function(Arena) body) {
  Arena arena = Arena();
  try {
    return runZoned(() => body(arena),
        zoneValues: {#_currentArena: arena},
        onError: (error, st) => throw RethrownError(error, st));
  } finally {
    arena.finalize();
  }
}
