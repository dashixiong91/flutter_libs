import 'dart:ffi';
import 'lib.dart';

typedef _add_native_t = Int32 Function(Int32, Int32);
typedef _add_t = int Function(int, int);

_add_t add = lib.lookup<NativeFunction<_add_native_t>>('add').asFunction();

