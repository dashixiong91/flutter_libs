import 'dart:ffi';
import 'dart:io';
import 'package:app_ffi/app_ffi.dart';
import 'package:flutter/foundation.dart';

// 直接 flutter test 的话，current 是 root/test，但如果点击测试上方的 run/debug ，current 是 root
final String projectRoot = Directory.current.path.endsWith('test')
    ? Directory.current.parent.path
    : Directory.current.path;

void buildTestLib() {
  String buildScriptPath = '$projectRoot/ios/build.sh';
  ProcessResult result = Process.runSync(buildScriptPath, <String>['build', 'cmake', 'macOS']);
  if (result.stderr.toString().isNotEmpty) {
    throw result.stderr.toString();
  }
}

LibLoader testLibLoader = (String libName) {
  if (!Platform.isMacOS) {
    throw UnsupportedError('Except macOS to run test');
  }
  String libPath = '';
  if (libName.contains('JavaScriptCore')) {
    libPath = '/System/Library/Frameworks/JavaScriptCore.framework/JavaScriptCore';
  } else {
    libPath = '$projectRoot/build/macos/lib/$libName';
    if (!File(libPath).existsSync()) {
      buildTestLib();
    }
  }
  debugPrint('testLibLoader:$libPath');
  return DynamicLibrary.open(libPath);
};

void testSetUp() {
  DynamicLibraryHelp.libLoader = testLibLoader;
}
