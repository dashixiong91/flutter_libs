import 'dart:ffi' as ffi;
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';

typedef LibLoader = ffi.DynamicLibrary Function(String libName);

class DynamicLibraryHelp {
  DynamicLibraryHelp._();
  static LibLoader libLoader;
  static final Map<String, ffi.DynamicLibrary> _libs = <String, ffi.DynamicLibrary>{};

  static ffi.DynamicLibrary load(String libName) {
    String fullLibName = 'lib$libName.so';
    if (Platform.isIOS || Platform.isMacOS) {
      fullLibName = '$libName.framework/$libName';
    }
    if (!_libs.containsKey(fullLibName)) {
      assert((){
        debugPrint('ffi:$fullLibName is loading');
        return true;
      }());
      if (libLoader != null) {
        _libs[fullLibName] = libLoader(fullLibName);
      } else {
        _libs[fullLibName] = ffi.DynamicLibrary.open(fullLibName);
      }
    }
    return _libs[fullLibName];
  }
}
