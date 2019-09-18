#!/usr/bin/env bash
# 此脚本可以单独构建.aar文件
set -e

THIS_DIR="$(cd "$(if [[ "${0:0:1}" == "/" ]]; then echo "$(dirname $0)";else echo "$PWD/$(dirname $0)";fi)"; pwd)"

FLUTTER_ENGINE_DIR="$FLUTTER_ROOT/bin/cache/artifacts/engine"
FLUTTER_ENGINE_JAR="$FLUTTER_ENGINE_DIR/android-arm/flutter.jar"
PROJECT_DIR="$THIS_DIR"

cp -f ${FLUTTER_ENGINE_JAR} ${PROJECT_DIR}/libs

gradle build
