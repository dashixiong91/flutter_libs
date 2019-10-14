#!/usr/bin/env bash
set -e

THIS_DIR="$(cd "$(if [[ "${0:0:1}" == "/" ]]; then echo "$(dirname $0)";else echo "$PWD/$(dirname $0)";fi)"; pwd)"

FLUTTER_PROJECT_ROOT="$THIS_DIR/.."

# test build Android and iOS lib
sh "${THIS_DIR}/build.sh"
# run cpp unit test
sh "${FLUTTER_PROJECT_ROOT}/cpp/test/test.sh"

# build test lib for run `flutter test`
sh "${FLUTTER_PROJECT_ROOT}/ios/build.sh build cmake macOS"
pushd ${FLUTTER_PROJECT_ROOT}
flutter test
popd
