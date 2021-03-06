#!/usr/bin/env bash
# 此脚本可以单独构建.aar文件
set -e

THIS_DIR="$(cd "$(if [[ "${0:0:1}" == "/" ]]; then echo "$(dirname $0)";else echo "$PWD/$(dirname $0)";fi)"; pwd)"

FLUTTER_BIN_PATH="$(command -v flutter 2>&1 || { echo >&2 "Error: Flutter SDK is not installed!!!."; exit 1; })"
FLUTTER_ROOT="${FLUTTER_ROOT:-$(dirname $(dirname $FLUTTER_BIN_PATH))}"
PROJECT_DIR="$THIS_DIR"
PROJECT_LIBS_DIR="${PROJECT_DIR}/libs"
BUILD_DIR="$PROJECT_DIR/../build/android"

function clean(){
  rm -rf ${BUILD_DIR}*
  rm -rf ${PROJECT_LIBS_DIR}
}
function build_aar(){
  pushd ${PROJECT_DIR}
  ./gradlew -PbuildDir=${BUILD_DIR} build
  popd
}
function init_dependencies(){
  mkdir -p ${PROJECT_LIBS_DIR}
  local flutter_jar="$FLUTTER_ROOT/bin/cache/artifacts/engine/android-arm/flutter.jar"
  cp -f ${flutter_jar} ${PROJECT_LIBS_DIR}
  echo -e "\033[36m INIT DEPENDENCY DONE (Android) ========= \033[0m"
}

function main(){
  local cmd args
  cmd="$1"
  args="${@#$cmd}"
  clean
  case ${cmd} in
      "init_dependencies")
        init_dependencies ${args}
      ;;
      "build"|*)
        init_dependencies ${args}
        build_aar
        echo -e "\033[36m BUILD SUCCESSFUL (Android) ========= \033[0m"
      ;;
  esac
}
main "$@"