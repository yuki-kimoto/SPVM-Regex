#include "spvm_native.h"

#include "re2/re2.h"

#include <iostream>
#include <string>
#include <assert.h>
#include <cstdio>

extern "C" {

int32_t SPVM__Regex__re2_test(SPVM_ENV* env, SPVM_VALUE* stack) {
  (void)env;
  (void)stack;
  
  RE2 re("(いうえ)");
  assert(re.ok());
  
  re2::StringPiece s;
  
  const char* string = "あいうえお";
  re2::StringPiece string_pease;
  string_pease.set(string);
  
  if (!RE2::PartialMatch(string_pease, re, &s)) {
    stack[0].ival = 0;
    return 0;
  }
  
  std::cout << "AAAAAAAAAAAAAA\n";
  std::cout << s;
  std::cout << "BBBB\n";
  std::cout << s.length();
  std::cout << "\n";
  std::cout << "CCCCC\n";
  
  stack[0].ival = 1;
  
  return 0;
}

}
