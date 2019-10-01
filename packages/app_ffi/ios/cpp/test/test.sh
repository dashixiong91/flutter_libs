#!/usr/bin/env bash
set -e

THIS_DIR="$(cd "$(if [[ "${0:0:1}" == "/" ]]; then echo "$(dirname $0)";else echo "$PWD/$(dirname $0)";fi)"; pwd)"

INCLUDE_DIR="${THIS_DIR}/../include"
SOURCE_DIR="${THIS_DIR}/../src"
BUILD_DIR="${THIS_DIR}/../../../build/cpptest"

function clean(){
  rm -rf ${BUILD_DIR}
}
function build_test(){
  mkdir -p ${BUILD_DIR}
  pushd ${THIS_DIR}
    for file in `ls -1A *_test.cc`
    do
      local base_name=`echo ${file} | awk -F '.' '{print $1}'`
      local out_file="${BUILD_DIR}/${base_name}.out"
      set +e
      clang++ $file ${SOURCE_DIR}/*.cc -I ${INCLUDE_DIR} -o ${out_file}
      set -e
      if [[ ! -f ${out_file} ]];then
        echo -e "\033[31m test[${file}]: not pass! \033[0m"
      else
        ${out_file}
        echo -e "\033[32m test[${file}]: pass! \033[0m"
      fi
    done
  popd
}
function main(){
  clean
  build_test
}
main "$@"
