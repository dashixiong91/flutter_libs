#!/usr/bin/env bash
# 此脚本可以单独构建.framework文件
set -e

THIS_DIR="$(cd "$(if [[ "${0:0:1}" == "/" ]]; then echo "$(dirname $0)";else echo "$PWD/$(dirname $0)";fi)"; pwd)"

function normalize_dir() {
  local dir="$1"
  echo "$(cd ${dir};pwd)"
}

FLUTTER_PROJECT_ROOT=`normalize_dir "$THIS_DIR/../"`
PROJECT_DIR="$THIS_DIR"
BUILD_DIR="$FLUTTER_PROJECT_ROOT/build/ios"
CMAKE_DIR="$FLUTTER_PROJECT_ROOT/cpp"

function clean() {
  rm -rf ${BUILD_DIR}
}

function build_cmake() {
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

# @Deprecated
function build_framework_by_cmake() {
  build_cmake
  pushd "${BUILD_DIR}"
  cmake --build ${BUILD_DIR} --config Release --target install
  popd
}
function build_framework_by_pod() {
  local pod_build_out_file="${TMPDIR}/app_ffi/pod_build_out.log";
  mkdir -p `dirname ${pod_build_out_file}`
  pushd "${PROJECT_DIR}"
    pod lib lint --verbose | tee "${pod_build_out_file}"
    if [[ ! -f ${pod_build_out_file} ]];then
      echo -e "\033[31m ERROR: build fail (iOS)!!! \033[0m"
      exit 1
    fi
    local build_temp_dir=`cat ${pod_build_out_file} | grep 'CreateBuildDirectory' | grep 'Products' | awk '{print $2}'`
    if [[ ! -d ${build_temp_dir} ]];then
      echo -e "\033[31m ERROR: build fail (iOS)!!! \033[0m"
      exit 1
    fi
    echo -e "\033[32m INFO: pod build temp to:${build_temp_dir} \033[0m"
    cp -r ${build_temp_dir} ${BUILD_DIR}
    mv ${pod_build_out_file} ${BUILD_DIR}
  popd
}

function build_framework() {
  local build_type="$1"
  if [[ "${build_type}" == "cmake" ]];then
    build_framework_by_cmake
  else
    build_framework_by_pod
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
        echo -e "\033[36m BUILD SUCCESSFUL (iOS) ========= \033[0m"
      ;;
  esac
}
main "$@"
