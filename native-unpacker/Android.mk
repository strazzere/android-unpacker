LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
  kisskiss.c
LOCAL_C_INCLUDE := $(ANDROID_NDK_SYSROOT)/usr/include/

LOCAL_MODULE := kisskiss
LOCAL_MODULE_TAGS := optional

include $(BUILD_STATIC_EXECUTABLE)

include $(BUILD_EXECUTABLE)

include $(call all-makefiles-under,$(LOCAL_PATH))
