//
// Created by xinfeng on 2019-09-16.
//
#include "app-ffi.h"
#include <iostream>
using namespace std;

int add(int a, int b) {
  return a + b;
}

class Box {
 public:
  double length;   // 盒子的长度
  double width;  // 盒子的宽度
  double height;   // 盒子的高度
  Box(double,double,double);
  double getVolume(void);
};

Box::Box(double l,double w,double h){
  length=l;
  width=w;
  height=h;
}
double Box::getVolume(void) {
  return length * width * height;
}

int main() {
  Box box1(10,20,30);
  cout << "Box2 的体积：" << box1.getVolume() << endl;
  return 0;
}