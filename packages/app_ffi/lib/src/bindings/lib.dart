import 'dart:ffi' as ffi;
import '../utils/dylib.dart';

const String LIBRARY_NAME='app_ffi';

ffi.DynamicLibrary lib = DynamicLibraryHelp.load(LIBRARY_NAME);
