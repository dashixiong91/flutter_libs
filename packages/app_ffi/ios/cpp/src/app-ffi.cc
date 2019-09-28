//
// Created by xinfeng on 2019-09-16.
//
#include "app-ffi.h"
#include <iostream>
#include <ctime>
using namespace std;

namespace jsc {
  int add(int a,int b){
    return a+b;
  }
}

int main(){
  // 基于当前系统的当前日期/时间
   time_t now = time(0);
   
   // 把 now 转换为字符串形式
   char* dt = ctime(&now);
 
   cout << "本地日期和时间：" << dt << endl;
 
   // 把 now 转换为 tm 结构
   tm *gmtm = gmtime(&now);
   dt = asctime(gmtm);
   cout << "UTC 日期和时间："<< dt << endl;
   return 0;
}