LOCAL_PATH := $(call my-dir)

LLVM90_ROOT_PATH := $(LOCAL_PATH)/../../../


#===---------------------------------------------------------------===
# lli-child-target command line tool
#===---------------------------------------------------------------===

lli_child_target_SRC_FILES := \
  ChildTarget.cpp \
  ../RemoteTarget.cpp

include $(CLEAR_VARS)

LOCAL_MODULE := lli-child-target
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_IS_HOST_MODULE := true

LOCAL_SRC_FILES := $(lli_child_target_SRC_FILES)

LOCAL_STATIC_LIBRARIES := \
  libLLVM90Support

LOCAL_LDLIBS += -lpthread -lm -ldl

include $(LLVM90_ROOT_PATH)/llvm.mk
include $(LLVM90_HOST_BUILD_MK)
include $(LLVM90_GEN_INTRINSICS_MK)
include $(BUILD_HOST_EXECUTABLE)
