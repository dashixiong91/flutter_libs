import 'dart:ffi';
import 'dart:io' show Platform;

class DynamicLibraryHelp {
  static Map<String, DynamicLibrary> _libs = <String, DynamicLibrary>{};

  DynamicLibraryHelp._();
  
  static DynamicLibrary load(String libName) {
    final String fullLibName = Platform.isIOS ? '$libName.framework/$libName' : 'lib$libName.so';
    if (!_libs.containsKey(fullLibName)) {
      _libs[fullLibName] = DynamicLibrary.open(fullLibName);
    }
    return _libs[fullLibName];
  }
}