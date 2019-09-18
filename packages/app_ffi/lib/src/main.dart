import 'dart:ffi';
import './utils/config.dart';
import './utils/dylib.dart';

/// 根据C中的函数来定义方法签名（所谓方法签名，就是对一个方法或函数的描述，包括返回值类型，形参类型）
/// 这里需要定义两个方法签名，一个是C语言中的，一个是转换为Dart之后的
typedef NativeAddSign = Int32 Function(Int32, Int32);
typedef DartAddSign = int Function(int, int);

DynamicLibrary dl;

void init(){
  dl=DynamicLibraryHelp.load(LIBRARY_NAME);
}

int add(int a,int b){
  DartAddSign method=dl.lookupFunction<NativeAddSign, DartAddSign>("add");
  return method(a,b);
}

