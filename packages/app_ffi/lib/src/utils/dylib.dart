import 'dart:ffi' as ffi;
import 'dart:io' show Platform;
import '../bindings/consts.dart';

typedef LibLoader = ffi.DynamicLibrary Function(String libName);

class DynamicLibraryHelp {
  DynamicLibraryHelp._();
  static LibLoader libLoader;
  static final Map<String, ffi.DynamicLibrary> _libs =
      <String, ffi.DynamicLibrary>{};

  static ffi.DynamicLibrary load(String libName) {
    String fullLibName = 'lib$libName.so';
    if (Platform.isIOS || Platform.isMacOS) {
      fullLibName = '$libName.framework/$libName';
    }
    if (!_libs.containsKey(fullLibName)) {
      assert(() {
        print('ffi:$fullLibName is loading');
        return true;
      }());
      ffi.DynamicLibrary lib;
      if (libLoader != null) {
        lib = libLoader(fullLibName);
      }
      if (lib == null) {
        // use DynamicLibrary if libLoader not specificed.
        lib = ffi.DynamicLibrary.open(fullLibName);
      }
      _libs[fullLibName] = lib;
    }
    return _libs[fullLibName];
  }

  static LibLoader get staticLibLoader {
    return (String libName) => libName.contains(LIBRARY_NAME) && Platform.isIOS ? ffi.DynamicLibrary.executable() : null;
  }
}
