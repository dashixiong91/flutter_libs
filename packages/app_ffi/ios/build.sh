#!/usr/bin/env bash
# 此脚本可以单独构建.framework文件
set -e

THIS_DIR="$(cd "$(if [[ "${0:0:1}" == "/" ]]; then echo "$(dirname $0)";else echo "$PWD/$(dirname $0)";fi)"; pwd)"

function normalize_dir() {
  local dir="$1"
  echo "$(cd ${dir};pwd)"
}

FLUTTER_BIN_PATH="$(command -v flutter 2>&1 || { echo >&2 "Error: Flutter SDK is not installed!!!."; exit 1; })"
FLUTTER_ROOT="${FLUTTER_ROOT:-$(dirname $(dirname $FLUTTER_BIN_PATH))}"
FLUTTER_PROJECT_ROOT=`normalize_dir "$THIS_DIR/../"`
PROJECT_DIR="$THIS_DIR"
BUILD_DIR="$FLUTTER_PROJECT_ROOT/build/`echo ${3:-iOS} | tr 'A-Z' 'a-z'`"
CMAKE_DIR="$FLUTTER_PROJECT_ROOT/cpp"

function clean() {
  rm -rf ${BUILD_DIR}
}

function build_cmake_ios() {
      mkdir -p ${BUILD_DIR}
      pushd "${BUILD_DIR}"
      cmake -S "${CMAKE_DIR}" -GXcode  \
      -DCMAKE_SYSTEM_NAME=iOS \
      "-DCMAKE_OSX_ARCHITECTURES=armv7;armv7s;arm64;i386;x86_64" \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=8.0 \
      -DCMAKE_INSTALL_PREFIX="${BUILD_DIR}" \
      -DCMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH=NO \
      -DCMAKE_IOS_INSTALL_COMBINED=YES
      popd
}
function build_cmake_macos() {
      mkdir -p ${BUILD_DIR}
      pushd "${BUILD_DIR}"
      cmake -S "${CMAKE_DIR}" -GXcode  \
      -DTARGET_SYSTEM_NAME=macOS \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 \
      -DCMAKE_INSTALL_PREFIX="${BUILD_DIR}" \
      -DCMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH=NO
      popd
}

# @Deprecated
function build_framework_by_cmake() {
  local build_target="$1"
  if [[ "${build_target}" == "macOS" ]];then
    build_cmake_macos
  else
    build_cmake_ios
  fi
  pushd "${BUILD_DIR}"
  cmake --build ${BUILD_DIR} --config Release --target install
  popd
}
function build_framework_by_pod() {
  local pod_build_out_file="${TMPDIR}/app_ffi/pod_build_out.log";
  mkdir -p `dirname ${pod_build_out_file}`
  local flutter_podspec="$FLUTTER_ROOT/bin/cache/artifacts/engine/ios/*.podspec"
  pushd "${PROJECT_DIR}"
    pod lib lint --verbose --allow-warnings --include-podspecs="${flutter_podspec}" | tee "${pod_build_out_file}"
    if [[ ! -f ${pod_build_out_file} ]];then
      echo -e "\033[31m ERROR: build fail[1] (iOS)!!! \033[0m"
      exit 1
    fi
    local build_temp_dir=`cat ${pod_build_out_file} | grep 'CreateBuildDirectory' | grep 'Products' | awk '{print $2}'`
    if [[ ! -d ${build_temp_dir} ]];then
      echo -e "\033[31m ERROR: build fail[2] (iOS)!!! \033[0m"
      exit 1
    fi
    local build_success_flag=`cat ${pod_build_out_file} | grep 'passed validation'`
    if [[ -z ${build_success_flag} ]];then
      echo -e "\033[31m ERROR: build fail[3] (iOS)!!! \033[0m"
      exit 1
    fi
    echo -e "\033[32m INFO: pod build temp to:${build_temp_dir} \033[0m"
    mkdir -p `dirname ${BUILD_DIR}`
    cp -r ${build_temp_dir} ${BUILD_DIR}
    mv ${pod_build_out_file} ${BUILD_DIR}
  popd
}

function build_framework() {
  local build_type="$1"
  local build_target="${2:-iOS}"
  if [[ "${build_type}" == "cmake" ]];then
    build_framework_by_cmake ${build_target}
    echo -e "\033[36m BUILD SUCCESSFUL (${build_target}) ========= \033[0m"
  else
    build_framework_by_pod ${build_target}
    echo -e "\033[36m BUILD SUCCESSFUL (iOS) ========= \033[0m"
  fi
}

function main(){
  local cmd args
  cmd="$1"
  args="${@#$cmd}"
  clean
  case ${cmd} in
      "build"|*)
        build_framework ${args}
      ;;
  esac
}
main "$@"
