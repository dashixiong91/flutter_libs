#include "app-ffi.h"
#include "iostream"
using namespace std;

int main(int argc, char const *argv[])
{
  int result = add(1,2);
  cout<<"add(1,2)"<<endl;
  cout<<result<<endl;
  return 0;
}
