# app_ffi

A flutter-ffi template,provide flutter-ffi template code in Flutter (c/c++ build and dart wrapper)

## Getting Started

1. env for android

- jdk 1.8 (expect $JAVA_HOME in env and java command in $PATH)
- android sdk (ndk >= 20.0.5594570、cmake >= 3.10.2.4988404 ...)
- environment variable ANDROID_HOME （eg: `export ANDROID_HOME=/opt/android-sdk-macosx`）
- environment variable ANDROID_NDK_HOME （eg: `export ANDROID_NDK_HOME=/opt/android-sdk-macosx/ndk/20.0.5594570`）

2. env for ios

- xcode (>= 11.1)
- cmake (>= 3.15.3 `brew install cmake`)

3. add dependencie for your app
```
dependencies:
  flutter:
    sdk: flutter
  app_ffi:
    git:
      url: https://github.com/xinfeng-tech/flutter_libs.git
      path: packages/app_ffi  
```

## For FFI Lib Developer

1. build ios app_ffi.framework

```
./ios/build.sh
# output to ./build/ios
```

2. build android app_ffi.aar

```
./android/build.sh
# output to ./build/android and ./build/android_native_build
```
