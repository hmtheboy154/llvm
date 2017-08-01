LOCAL_PATH := $(call my-dir)

LLVM_ROOT_PATH := $(LOCAL_PATH)/../..


#===---------------------------------------------------------------===
# llvm-extract command line tool
#===---------------------------------------------------------------===

llvm_extract_SRC_FILES := \
  llvm-extract.cpp

llvm_extract_STATIC_LIBRARIES := \
  libLLVM60IRReader                \
  libLLVM60AsmParser               \
  libLLVM60Object                  \
  libLLVM60BitReader               \
  libLLVM60BitWriter               \
  libLLVM60ipo                     \
  libLLVM60TransformUtils          \
  libLLVM60Analysis                \
  libLLVM60Target                  \
  libLLVM60Core                    \
  libLLVM60Support                 \

include $(CLEAR_VARS)

LOCAL_MODULE := llvm-extract
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_IS_HOST_MODULE := true

LOCAL_SRC_FILES := $(llvm_extract_SRC_FILES)

LOCAL_STATIC_LIBRARIES := $(llvm_extract_STATIC_LIBRARIES)

LOCAL_LDLIBS += -lpthread -lm -ldl

include $(LLVM_ROOT_PATH)/llvm.mk
include $(LLVM_HOST_BUILD_MK)
include $(LLVM_GEN_ATTRIBUTES_MK)
include $(LLVM_GEN_INTRINSICS_MK)
include $(BUILD_HOST_EXECUTABLE)
