import 'dart:ffi';
import 'package:flutter/foundation.dart';

import './utils/config.dart';
import './utils/dylib.dart';

DynamicLibrary lib = () {
  return DynamicLibraryHelp.load(LIBRARY_NAME);
}();

typedef _add_native_t = Int32 Function(Int32, Int32);
int Function(int a,int b) add=lib.lookup<NativeFunction<_add_native_t>>("add").asFunction();


typedef _main_native_t = Int32 Function();
int Function() main = lib.lookup<NativeFunction<_main_native_t>>("main").asFunction();


typedef _box_constructor_native_t = Void Function(Double, Double, Double);
typedef _box_constructor_dart_t = void Function(double, double, double);

class BoxClass extends Struct<BoxClass>{
  @Double()
  double length;
  @Double()
  double width;
  @Double()
  double height; 
}

class Box{
  Box(double length, double width, double height) {
    try {
      Function constructor=lib.lookupFunction<_box_constructor_native_t,_box_constructor_dart_t>('_ZN3BoxC1Eddd');
      debugPrint('$constructor');
    } catch (exception, stack) {
      debugPrint('1');
    }
  }
  double getVolume() {
    Function method=lib.lookup<NativeFunction<_box_constructor_native_t>>('_ZN3Box9getVolumeEv').asFunction();
    return 0;
  }
}
