# Sets the minimum version of CMake required to build your native library.
# This ensures that a certain set of CMake features is available to
# your build.

cmake_minimum_required(VERSION 3.15)

project(app-ffi)

# Specifies a path to native header files.
include_directories(include/)

# Specifies a library name, specifies whether the library is STATIC or
# SHARED, and provides relative paths to the source code. You can
# define multiple libraries by adding multiple add_library() commands,
# and CMake builds them for you. When you build your app, Gradle
# automatically packages shared libraries with your APK.

add_library(
    app-ffi
    SHARED
    src/app-ffi.c)

set_target_properties(app-ffi PROPERTIES
  FRAMEWORK TRUE
  FRAMEWORK_VERSION A
  MACOSX_FRAMEWORK_IDENTIFIER com.xin1t.app-ffi
)

install(TARGETS app-ffi DESTINATION lib)


