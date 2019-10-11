#!/usr/bin/env bash
set -e

THIS_DIR="$(cd "$(if [[ "${0:0:1}" == "/" ]]; then echo "$(dirname $0)";else echo "$PWD/$(dirname $0)";fi)"; pwd)"

FLUTTER_PROJECT_ROOT="$THIS_DIR/.."

sh "${FLUTTER_PROJECT_ROOT}/cpp/test/test.sh"

pushd ${FLUTTER_PROJECT_ROOT}
flutter test
popd