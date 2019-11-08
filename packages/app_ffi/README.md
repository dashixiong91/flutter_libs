# app_ffi

A flutter-ffi template,provide flutter-ffi template code in Flutter (c/c++ build and dart wrapper)

## Getting Started

1. env for Android

- jdk 1.8 (expect $JAVA_HOME in env and java command in $PATH)
- android sdk (ndk >= 20.0.5594570、cmake >= 3.6.4111459 ...)
- environment variable ANDROID_HOME （eg: `export ANDROID_HOME=/opt/android-sdk-macosx`）
- environment variable ANDROID_NDK_HOME （eg: `export ANDROID_NDK_HOME=/opt/android-sdk-macosx/ndk/20.0.5594570`）

2. env for iOS

- xcode (>= 11.1)
- cmake (>= 3.15.3 `brew install cmake`)

3. add dependencie for your app

```yaml
dependencies:
  flutter:
    sdk: flutter
  app_ffi:
    git:
      url: https://github.com/xinfeng-tech/flutter_libs.git
      path: packages/app_ffi 
```

4. note
> If you use app_ffi as static library on iOS platform, please add bellow code before any use of app_ffi:

```dart
DynamicLibraryHelp.libLoader = DynamicLibraryHelp.staticLibLoader;
```

## For FFI Lib Developer

- install yarn
```shell
brew install yarn
```

- init project

```shell
yarn
# or yarn install
```

- build iOS app_ffi.framework

```shell
yarn build:ios
# output to ./build/ios
```

- build Android app_ffi.aar

```shell
yarn build:android
# output to ./build/android 
# and ./build/android_native_build
```

- build all (above Android and iOS build)

```shell
yarn build
```

- run unit test

```shell
yarn test
```

- commit code

```shell
yarn commit
```

- publish a new version

```shell
# auto update CHANGELOG.md file
yarn version
```
