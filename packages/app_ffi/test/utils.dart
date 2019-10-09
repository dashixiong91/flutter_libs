import 'dart:ffi';
import 'dart:io';
import 'package:app_ffi/app_ffi.dart';

 // 直接 flutter test 的话，current 是 root/test，但如果点击测试上方的 run/debug ，current 是 root
final String projectRoot = Directory.current.path.endsWith('test') ? Directory.current.parent.path : Directory.current.path;

LibLoader testLoader=(String libName){
  if(!Platform.isMacOS){
    throw UnsupportedError('Except macOS to run test');
  }
  String libPath='$projectRoot/build/macos/lib/$libName';
  if(!File(libPath).existsSync()){
    buildTestLib();
  }
  return DynamicLibrary.open(libPath);
};

void buildTestLib() {
  String buildScriptPath='$projectRoot/ios/build.sh';
  ProcessResult result = Process.runSync(buildScriptPath, [
    'build',
    'cmake',
    'macOS'
  ]);
  if (result.stderr.toString().isNotEmpty) {
    throw result.stderr.toString();
  }
}