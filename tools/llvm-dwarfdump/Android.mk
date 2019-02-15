LOCAL_PATH := $(call my-dir)

LLVM80_ROOT_PATH := $(LOCAL_PATH)/../..


#===---------------------------------------------------------------===
# llvm-dwarfdump command line tool
#===---------------------------------------------------------------===

llvm_dwarfdump_SRC_FILES := \
  llvm-dwarfdump.cpp

llvm_dwarfdump_STATIC_LIBRARIES := \
  libLLVM80DebugInfoDWARF            \
  libLLVM80DebugInfoPDB              \
  libLLVM80Object                    \
  libLLVM80BitReader                 \
  libLLVM80MC                        \
  libLLVM80MCParser                  \
  libLLVM80Core                      \
  libLLVM80Support                   \

include $(CLEAR_VARS)

LOCAL_MODULE := llvm-dwarfdump
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_IS_HOST_MODULE := true

LOCAL_SRC_FILES := $(llvm_dwarfdump_SRC_FILES)

LOCAL_STATIC_LIBRARIES := $(llvm_dwarfdump_STATIC_LIBRARIES)

LOCAL_LDLIBS += -lpthread -lm -ldl

include $(LLVM80_ROOT_PATH)/llvm.mk
include $(LLVM80_HOST_BUILD_MK)
include $(LLVM80_GEN_INTRINSICS_MK)
include $(BUILD_HOST_EXECUTABLE)
