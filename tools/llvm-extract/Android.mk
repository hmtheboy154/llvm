LOCAL_PATH := $(call my-dir)

LLVM50_ROOT_PATH := $(LOCAL_PATH)/../..


#===---------------------------------------------------------------===
# llvm-extract command line tool
#===---------------------------------------------------------------===

llvm_extract_SRC_FILES := \
  llvm-extract.cpp

llvm_extract_STATIC_LIBRARIES := \
  libLLVM50IRReader                \
  libLLVM50AsmParser               \
  libLLVM50Object                  \
  libLLVM50BitReader               \
  libLLVM50BitWriter               \
  libLLVM50ipo                     \
  libLLVM50TransformUtils          \
  libLLVM50Analysis                \
  libLLVM50Target                  \
  libLLVM50Core                    \
  libLLVM50Support                 \

include $(CLEAR_VARS)

LOCAL_MODULE := llvm-extract
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_IS_HOST_MODULE := true

LOCAL_SRC_FILES := $(llvm_extract_SRC_FILES)

LOCAL_STATIC_LIBRARIES := $(llvm_extract_STATIC_LIBRARIES)

LOCAL_LDLIBS += -lpthread -lm -ldl

include $(LLVM50_ROOT_PATH)/llvm.mk
include $(LLVM_HOST_BUILD_MK)
include $(LLVM_GEN_ATTRIBUTES_MK)
include $(LLVM_GEN_INTRINSICS_MK)
include $(BUILD_HOST_EXECUTABLE)
