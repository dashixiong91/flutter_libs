# app_ffi

A flutter-ffi template.

## Getting Started

1. env for android

- android sdk (ndk、cmake...)
- environment variable ANDROID_HOME （eg: `export ANDROID_HOME=/opt/android-sdk-macosx`）
- environment variable ANDROID_NDK_HOME （eg: `export ANDROID_NDK_HOME=/opt/android-sdk-macosx/ndk/20.0.5594570`）

2. env for ios

- xcode
- cmake (`brew install cmake`)

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

1. in addition to the other env above
- gradle (`brew install gradle`)

2. build ios app_ffi.framework

```
./ios/build.sh
# output to ./build/ios
```

3. build android app_ffi.aar

```
./android/build.sh
# output to ./build/android and ./build/android_native_build
```
