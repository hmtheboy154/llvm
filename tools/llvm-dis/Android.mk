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
  libLLVM80Analysis \
  libLLVM80BitReader \
  libLLVM80Core \
  libLLVM80Support

include $(LLVM80_HOST_BUILD_MK)
include $(LLVM80_GEN_ATTRIBUTES_MK)
include $(LLVM80_GEN_INTRINSICS_MK)
include $(BUILD_HOST_EXECUTABLE)
