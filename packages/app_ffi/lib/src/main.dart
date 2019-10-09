import 'dart:ffi';
import './utils/config.dart';
import './utils/dylib.dart';

DynamicLibrary lib = () {
  return DynamicLibraryHelp.load(LIBRARY_NAME);
}();

typedef _add_native_t = Int32 Function(Int32, Int32);
int Function(int a,int b) add=lib.lookup<NativeFunction<_add_native_t>>("add").asFunction();
