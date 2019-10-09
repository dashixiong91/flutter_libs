import 'dart:ffi';
import '../utils/dylib.dart';

const String LIBRARY_NAME='app_ffi';

DynamicLibrary lib = DynamicLibraryHelp.load(LIBRARY_NAME);
