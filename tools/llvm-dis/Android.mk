LOCAL_PATH:= $(call my-dir)

llvm_dis_SRC_FILES := \
  llvm-dis.cpp

include $(CLEAR_VARS)

LOCAL_MODULE := llvm-dis
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(llvm_dis_SRC_FILES)
LOCAL_LDLIBS += -lpthread -lm -ldl

LOCAL_STATIC_LIBRARIES := \
  libLLVM90Analysis \
  libLLVM90BitReader \
  libLLVM90Core \
  libLLVM90Support

include $(LLVM90_HOST_BUILD_MK)
include $(LLVM90_GEN_ATTRIBUTES_MK)
include $(LLVM90_GEN_INTRINSICS_MK)
include $(BUILD_HOST_EXECUTABLE)
