import 'dart:ffi' as ffi;
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
  String buildError=result.stderr.toString();
  if (buildError.isNotEmpty) {
    debugPrint(buildError);
    throw 'buildTestLib Error';
  }
}
bool isNeedBuildTestLib() {
  String lastHashFile='$projectRoot/build/macos/build_hash.txt';
  if(!File(lastHashFile).existsSync()){
    return true;
  }
  ProcessResult lastHashResult =Process.runSync('cat', <String>[lastHashFile]);
  if (lastHashResult.stderr.toString().isNotEmpty) {
    return true;
  }
  String buildScriptPath = '$projectRoot/ios/build.sh';
  ProcessResult filesHashResult = Process.runSync(buildScriptPath, <String>['files_hash']);
  String buildError=filesHashResult.stderr.toString();
  if (buildError.isNotEmpty) {
    debugPrint('get files hash Error: $buildError');
    return true;
  }
  return '${filesHashResult.stdout}'!='${lastHashResult.stdout}';
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
    // FIXME(qianxinfeng): test case is run at same time,test lib will build multi time
    if(!File(libPath).existsSync()||isNeedBuildTestLib()){
      debugPrint('testLib: Rebuild lib for test...');
      buildTestLib();
    }
  }
  debugPrint('testLib: $libPath');
  return ffi.DynamicLibrary.open(libPath);
};

void testSetUp() {
  DynamicLibraryHelp.libLoader = testLibLoader;
}
