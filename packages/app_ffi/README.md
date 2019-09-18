# app_ffi

A Flutter app ffi project

## Getting Started

1. android环境准备

- 安装android sdk (必选：ndk、cmake)
- 设置环境变量ANDROID_HOME （eg: `export ANDROID_HOME=/opt/android-sdk-macosx`）
- 设置环境变量ANDROID_NDK_HOME （eg: `export ANDROID_NDK_HOME=/opt/android-sdk-macosx/ndk/20.0.5594570`）

2. ios环境准备

- 安装xcode
- 安装cmake (`brew install cmake`)

2. 编译打包 ios .framework文件

```
./ios/build.sh
```

3. 编译打包 android .aar文件 

```
./android/build.sh
```
