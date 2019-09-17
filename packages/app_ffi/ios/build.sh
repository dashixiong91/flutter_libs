#!/usr/bin/env bash

set -e

PROJECT_NAME="app_ffi"

THIS_DIR="$(cd "$(if [[ "${0:0:1}" == "/" ]]; then echo "$(dirname $0)";else echo "$PWD/$(dirname $0)";fi)"; pwd)"

function normalize_dir() {
  local dir="$1"
  echo "$(cd ${dir};pwd)"
}

function clean() {
  rm -rf ${BUILD_DIR}
  mkdir -p ${BUILD_DIR}
}

function build_cmake() {
      pushd "${BUILD_DIR}"
      cmake -S "${CMAKE_DIR}" -GXcode  \
      -DCMAKE_SYSTEM_NAME=iOS \
      "-DCMAKE_OSX_ARCHITECTURES=armv7;armv7s;arm64;i386;x86_64" \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=9.3 \
      -DCMAKE_INSTALL_PREFIX="${BUILD_DIR}" \
      -DCMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH=NO \
      -DCMAKE_IOS_INSTALL_COMBINED=YES
      popd
}

function build_framework() {
  cmake --build ${BUILD_DIR} --config Release --target install
}

function move_to_app_frameworks() {
  # TODO move *.framework to Runner.app/Frameworks
  echo 'TODO '
}

PLUGIN_DIR=`normalize_dir "$THIS_DIR/../"`
FLUTTER_PROJECT_ROOT=${FLUTTER_PROJECT_ROOT:-`normalize_dir $PLUGIN_DIR/../../../../`}
IOS_PROJECT_ROOT="$FLUTTER_PROJECT_ROOT/ios"
BUILD_DIR="$FLUTTER_PROJECT_ROOT/build/ffi/$PROJECT_NAME"
CMAKE_DIR="$PLUGIN_DIR/cpp"

function main() {
    clean
    build_cmake
    build_framework
}

main "$@"
