#!/usr/bin/env bash
set -e

THIS_DIR="$(cd "$(if [[ "${0:0:1}" == "/" ]]; then echo "$(dirname $0)";else echo "$PWD/$(dirname $0)";fi)"; pwd)"

sh "${THIS_DIR}/../ios/build.sh"
sh "${THIS_DIR}/../android/build.sh"
