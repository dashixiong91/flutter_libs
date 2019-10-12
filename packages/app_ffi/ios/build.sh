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
function get_codesign_id(){
  if [[ ! -z $CODE_SIGN_IDENTITY ]];then
    echo "$CODE_SIGN_IDENTITY"
    return
  fi
  local cert_id=`security find-identity -p codesigning -v | grep 'Developer' | awk 'NR==1' | awk -F '[()]' '{print $3}'`
  if [[ -z $cert_id ]];then
    echo -e "\033[31m ERROR: can not find a valid Developer Cert !!! \033[0m"
    exit 1
  fi
  local cert_content=`security find-certificate -c ${cert_id} -p`
  local identity=`security find-certificate -c ${cert_id} -p | openssl x509 -subject | awk 'NR==1' | awk -F 'OU=' '{print $2}' | awk -F '/' '{print $1}'`
  if [[ -z $identity ]];then
    echo -e "\033[31m ERROR: can not find a IDENTITY to sign code !!! \033[0m"
    exit 1
  fi
  echo "$identity"
}
function get_files_hash(){
  local temp_zip="${TMPDIR}app_ffi/cpp.zip"
  rm -rf $temp_zip
  mkdir -p `dirname $temp_zip`
  zip -r1q $temp_zip $CMAKE_DIR
  local hash=`md5 -q $temp_zip`
  rm -rf $temp_zip
  echo $hash
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
      local identity=`get_codesign_id`
      local hash=`get_files_hash`
      mkdir -p ${BUILD_DIR}
      pushd "${BUILD_DIR}"
      cmake -S "${CMAKE_DIR}" -GXcode  \
      -DTARGET_SYSTEM_NAME=macOS \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=10.10 \
      -DCMAKE_INSTALL_PREFIX="${BUILD_DIR}" \
      -DCMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH=NO \
      -DCMAKE_XCODE_ATTRIBUTE_DEVELOPMENT_TEAM=${identity}
      popd
      echo $hash > "${BUILD_DIR}/files_hash.txt"
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
    pod lib lint --verbose --no-clean --allow-warnings --include-podspecs="${flutter_podspec}" | tee "${pod_build_out_file}"
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
      "files_hash")
        get_files_hash
      ;;
      "build"|*)
        build_framework ${args}
      ;;
  esac
}
main "$@"
