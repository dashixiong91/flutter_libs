import 'dart:ffi' as ffi;
import 'consts.dart';
import '../utils/dylib.dart';

ffi.DynamicLibrary lib = DynamicLibraryHelp.load(LIBRARY_NAME);
