#include "spvm_native.h"

#include "re2/re2.h"

#include <iostream>
#include <string>
#include <assert.h>
#include <cstdio>

const char* FILE_NAME = "SPVM/Regex.cpp";

extern "C" {

int32_t SPVM__Regex__re2_test(SPVM_ENV* env, SPVM_VALUE* stack) {
  (void)env;
  (void)stack;
  
  RE2 re("(いうえ)");
  assert(re.ok());
  
  re2::StringPiece s;
  
  const char* regex_string = "あいうえお";
  re2::StringPiece regex_string_pease;
  regex_string_pease.set(regex_string);
  
  if (!RE2::PartialMatch(regex_string_pease, re, &s)) {
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

int32_t SPVM__Regex__compile2(SPVM_ENV* env, SPVM_VALUE* stack) {
  (void)env;
  (void)stack;
  
  int32_t e;

  void* obj_self = stack[0].oval;
  
  void* obj_regex_string = stack[1].oval;
  
  if (!obj_regex_string) {
    return env->die(env, stack, "The regex string must be defined", FILE_NAME, __LINE__);
  }
  
  const char* regex_string = env->get_chars(env, stack, obj_regex_string);
  int32_t regex_string_length = env->length(env, stack, obj_regex_string);
  
  RE2* re2 = new RE2(regex_string);
  
  if (!re2->ok()) {
    return env->die(env, stack, "The regex string can't be compiled for syntax error", FILE_NAME, __LINE__);
  }
  
  void* obj_re2 = env->new_object_by_name(env, stack, "Regex::Re2", &e, FILE_NAME, __LINE__);
  if (e) { return e; }
  
  env->set_pointer(env, stack, obj_re2, re2);
  
  env->set_field_object_by_name(env, stack, obj_self, "Regex", "re2", "Regex::Re2", obj_re2, &e, FILE_NAME, __LINE__);
  if (e) { return e; }
  
  return 0;
}

int32_t SPVM__Regex__DESTROY(SPVM_ENV* env, SPVM_VALUE* stack) {
  void* obj_self = stack[0].oval;
  
  RE2* re2 = (RE2*)env->get_pointer(env, stack, obj_self);
  
  if (re2) {
    delete re2;
    env->set_pointer(env, stack, obj_self, NULL);
  }
}
}
