import 'dart:ffi';
import 'dart:io' show Platform;

class DynamicLibraryHelp {
  DynamicLibraryHelp._();
  static final Map<String, DynamicLibrary> _libs = <String, DynamicLibrary>{};
  
  static DynamicLibrary load(String libName) {
    String fullLibName = 'lib$libName.so';
    if(Platform.isIOS||Platform.isMacOS){
      fullLibName = '$libName.framework/$libName';
    }
    if (!_libs.containsKey(fullLibName)) {
      _libs[fullLibName] = DynamicLibrary.open(fullLibName);
    }
    return _libs[fullLibName];
  }
}