// Copyright (c) 2023 Yuki Kimoto
// MIT License

#include "spvm_native.h"

#include "re2/re2.h"

#include <iostream>
#include <string>
#include <assert.h>
#include <cstdio>
#include <vector>
#include<memory>

static const char* FILE_NAME = "Regex.cpp";

extern "C" {

int32_t SPVM__Regex__compile(SPVM_ENV* env, SPVM_VALUE* stack) {
  
  int32_t error_id = 0;

  void* obj_self = stack[0].oval;
  
  void* obj_pattern = stack[1].oval;
  
  const char* pattern = env->get_chars(env, stack, obj_pattern);
  int32_t pattern_length = env->length(env, stack, obj_pattern);
  
  RE2::Options options;
  options.set_log_errors(false);
  re2::StringPiece stp_pattern(pattern, pattern_length);
  
  std::unique_ptr<RE2> re2(new RE2(stp_pattern, options));
  
  if (!re2->ok()) {
    std::string error = re2->error();
    return env->die(env, stack, "The regex pattern $pattern \"%s\" can't be compiled: %s.", pattern, error.data(), __func__, FILE_NAME, __LINE__);
  }
  
  void* obj_re2 = env->new_pointer_object_by_name(env, stack, "Regex::RE2", re2.release(), &error_id, __func__, FILE_NAME, __LINE__);
  if (error_id) { return error_id; }
  
  env->set_field_object_by_name(env, stack, obj_self, "re2", obj_re2, &error_id, __func__, FILE_NAME, __LINE__);
  if (error_id) { return error_id; }
  
  return 0;
}

int32_t SPVM__Regex__match_string(SPVM_ENV* env, SPVM_VALUE* stack) {
  
  int32_t error_id = 0;
  
  void* obj_self = stack[0].oval;
  
  void* obj_string = stack[1].oval;
  
  assert(obj_string);
  
  const char* string = env->get_chars(env, stack, obj_string);
  int32_t string_length = env->length(env, stack, obj_string);
  
  int32_t* offset_ref = stack[2].iref;
  
  if (!offset_ref) {
    int32_t offset_tmp = 0;
    offset_ref = &offset_tmp;
  }
  
  int32_t offset = *offset_ref;
  assert(offset >= 0);
  
  int32_t length = stack[3].ival;
  
  if (length < 0) {
    length = string_length - offset;
  }
  
  assert(offset + length <= string_length);
  
  void* obj_re2 = env->get_field_object_by_name(env, stack, obj_self, "re2", &error_id, __func__, FILE_NAME, __LINE__);
  if (error_id) { return error_id; }
  
  assert(obj_re2);
  
  RE2* re2 = (RE2*)env->get_pointer(env, stack, obj_re2);
  
  int32_t captures_length = re2->NumberOfCapturingGroups();
  int32_t doller0_and_captures_length = captures_length + 1;
  
  std::vector<re2::StringPiece> submatch(doller0_and_captures_length);
  int32_t match = re2->Match(string, offset, offset + length, re2::RE2::Anchor::UNANCHORED, submatch.data(), doller0_and_captures_length);
  
  void* obj_regex_match = NULL;
  if (match) {
    int32_t success = 1;
    int32_t match_start = -1;
    int32_t match_length = -1;
    void* obj_captures = env->new_string_array(env, stack, doller0_and_captures_length);
    
    // Captures
    {
      for (int32_t i = 0; i < doller0_and_captures_length; ++i) {
        if (i == 0) {
          match_start = (submatch[0].data() - string);
          match_length = submatch[0].length();
        }
        else {
          void* obj_capture = env->new_string(env, stack, submatch[i].data(), submatch[i].length());
          env->set_elem_object(env, stack, obj_captures, i, obj_capture);
        }
      }
    }
    
    {
      stack[0].ival = success;
      stack[1].oval = obj_captures;
      stack[2].ival = match_start;
      stack[3].ival = match_length;
      
      env->call_class_method_by_name(env, stack, "Regex::Match", "_new", 4, &error_id, __func__, FILE_NAME, __LINE__);
      if (error_id) { return error_id; }
      
      obj_regex_match = stack[0].oval;
    }
    
    // Next offset
    int32_t next_offset = (submatch[0].data() - string) + submatch[0].length();
    *offset_ref = next_offset;
    
    stack[0].oval = obj_regex_match;
  }
  else {
    stack[0].oval = obj_regex_match;
  }
  
  return 0;
}

int32_t SPVM__Regex__DESTROY(SPVM_ENV* env, SPVM_VALUE* stack) {
  int32_t error_id = 0;
  
  void* obj_self = stack[0].oval;

  void* obj_re2 = env->get_field_object_by_name(env, stack, obj_self, "re2", &error_id, __func__, FILE_NAME, __LINE__);
  if (error_id) { return error_id; }
  
  if (obj_re2) {
    // Free RE2 object
    RE2* re2 = (RE2*)env->get_pointer(env, stack, obj_re2);
    if (re2) {
      delete re2;
      env->set_pointer(env, stack, obj_re2, NULL);
    }
  }
  
  return 0;
}
}
