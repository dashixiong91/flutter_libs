#!/usr/bin/env bash
set -e

THIS_DIR="$(cd "$(if [[ "${0:0:1}" == "/" ]]; then echo "$(dirname $0)";else echo "$PWD/$(dirname $0)";fi)"; pwd)"
PROJECT_ROOT="$THIS_DIR/.."

echo -e "\033[32m INFO: please make sure your machine env is ok(like README.md say)! \033[0m"
