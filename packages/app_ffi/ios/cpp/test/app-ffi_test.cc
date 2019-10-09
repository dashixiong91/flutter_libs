//
// Created by xinfeng on 2019-09-16.
//
#include "app-ffi.h"
#include "iostream"
using namespace std;

int main(int argc, char const *argv[])
{
  int result = add(1,2);
  cout << "add(1,2)=>" << result<< endl;
  if(result!=3){
    return 1;
  }
  return 0;
}


