#include "spvm_native.h"

#include "re2/re2.h"

extern "C" {

int32_t SPVM__Regex__foo(SPVM_ENV* env, SPVM_VALUE* stack) {
  (void)env;
  (void)stack;
  
  return 0;
}

}
