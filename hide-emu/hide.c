/*
 * stupid hide qemu ld_preload hack for APKProtect
 *
 * Tim "diff" Strazzere <strazz@gmail.com>
 *
 * Likely took a some of code from @pof :)
 *   https://github.com/poliva/ldpreloadhook
 */

#include <stdlib.h>
#include <dlfcn.h>
#include <android/log.h>

#define LOG_TAG "StupidHideQemu"
#define LOGD(...)  __android_log_print(ANDROID_LOG_DEBUG, LOG_TAG, __VA_ARGS__)
#define DPRINTF(...)  __android_log_print(ANDROID_LOG_DEBUG, LOG_TAG, __VA_ARGS__)

static void _libhook_init() __attribute__ ((constructor));
static void _libhook_init() {   
  LOGD("[] Hooking!\n");
}

size_t strlen(const char* s) {

  static size_t (*func_strlen) (const char *) = NULL;
  int retval = 0;

  if(! func_strlen)
    func_strlen = (size_t (*) (const char*)) dlsym (RTLD_NEXT, "strlen");

  if(strcmp(s, "/system/bin/qemud") == 0) {
    LOGD("[] Caught apkprotect checking for the qemu");
    return 1;
  }

  return func_strlen(s);
}
