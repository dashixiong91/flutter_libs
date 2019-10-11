import 'dart:ffi' as ffi;
import '../lib.dart';

typedef _add_native_t = ffi.Int32 Function(ffi.Int32, ffi.Int32);
typedef _add_t = int Function(int, int);

_add_t add = lib.lookup<ffi.NativeFunction<_add_native_t>>('add').asFunction();

