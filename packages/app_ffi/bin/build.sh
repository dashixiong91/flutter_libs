#!/usr/bin/env bash
set -e

THIS_DIR="$(cd "$(if [[ "${0:0:1}" == "/" ]]; then echo "$(dirname $0)";else echo "$PWD/$(dirname $0)";fi)"; pwd)"

PROJECT_ROOT="$THIS_DIR/.."

sh "${PROJECT_ROOT}/ios/build.sh"
sh "${PROJECT_ROOT}/android/build.sh"
