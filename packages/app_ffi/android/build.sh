#!/usr/bin/env bash
# 此脚本可以单独构建.aar文件
set -e

THIS_DIR="$(cd "$(if [[ "${0:0:1}" == "/" ]]; then echo "$(dirname $0)";else echo "$PWD/$(dirname $0)";fi)"; pwd)"

FLUTTER_ENGINE_DIR="$FLUTTER_ROOT/bin/cache/artifacts/engine"
FLUTTER_ENGINE_JAR="$FLUTTER_ENGINE_DIR/android-arm/flutter.jar"
PROJECT_DIR="$THIS_DIR"
PROJECT_LIBS_DIR="${PROJECT_DIR}/libs"
BUILD_DIR="$PROJECT_DIR/../build/android"

function clean(){
  rm -rf ${BUILD_DIR}*
  rm -rf ${PROJECT_LIBS_DIR}
  mkdir -p ${PROJECT_LIBS_DIR}
  cp -f ${FLUTTER_ENGINE_JAR} ${PROJECT_LIBS_DIR}
}
function gradle_build(){
  pushd ${PROJECT_DIR}
  ./gradlew -PbuildDir=${BUILD_DIR} build
  popd
}
function main(){
  clean
  gradle_build
  echo "BUILD SUCCESSFUL (ANDROID)   ========="
}
main "$@"