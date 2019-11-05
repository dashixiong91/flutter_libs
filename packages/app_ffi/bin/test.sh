#!/usr/bin/env bash
set -e

THIS_DIR="$(cd "$(if [[ "${0:0:1}" == "/" ]]; then echo "$(dirname $0)";else echo "$PWD/$(dirname $0)";fi)"; pwd)"
PROJECT_ROOT="$THIS_DIR/.."

sh "${THIS_DIR}/init.sh"

echo "[test]run Android and iOS lib build"
sh "${THIS_DIR}/build.sh"

echo "[test]run cpp unit test"
sh "${PROJECT_ROOT}/cpp/test/test.sh"

echo "[test]run flutter unit test"
# build test lib for run `flutter test`
sh "${PROJECT_ROOT}/ios/build.sh" build cmake macOS
pushd ${PROJECT_ROOT}
  flutter test
popd

echo "[test]run app_ffi-example build"
pushd ${PROJECT_ROOT}/example
  flutter clean
  flutter build apk --target-platform=android-arm
  # TODO(qianxinfeng): iOS release mode cannot be build successfully under current flutter@1.10.14, temporarily only check debug mode
  flutter build ios --debug --no-codesign
popd
