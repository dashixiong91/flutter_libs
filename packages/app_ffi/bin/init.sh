#!/usr/bin/env bash
set -e

THIS_DIR="$(cd "$(if [[ "${0:0:1}" == "/" ]]; then echo "$(dirname $0)";else echo "$PWD/$(dirname $0)";fi)"; pwd)"
PROJECT_ROOT="$THIS_DIR/.."

echo "init..."
pushd ${PROJECT_ROOT}
    rm -rf .packages
    rm -rf ./example/.packages
    flutter packages get
popd

echo -e "\033[33m NOTE: please make sure your machine env is ok(like README.md say)! \033[0m"
