LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_LDLIBS := -llog

LOCAL_SRC_FILES := \
  hide.c
LOCAL_C_INCLUDE := $(SYSROOT)/usr/include/

LOCAL_MODULE := hide
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

include $(call all-makefiles-under,$(LOCAL_PATH))
