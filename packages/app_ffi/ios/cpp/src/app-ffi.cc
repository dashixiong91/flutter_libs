//
// Created by xinfeng on 2019-09-16.
//
#include "app-ffi.h"
#include <ctime>
#include <iostream>
using namespace std;

namespace jsc {
int add(int a, int b) {
  return a + b;
}
struct Books {
  char title[50];
  char author[50];
  char subject[100];
  int book_id;
} book;
}  // namespace jsc

int main() {
  return 0;
}