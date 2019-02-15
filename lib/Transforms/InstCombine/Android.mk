LOCAL_PATH:= $(call my-dir)

transforms_inst_combine_TBLGEN_TABLES80 := \
  InstCombineTables.inc

transforms_inst_combine_SRC_FILES := \
  InstructionCombining.cpp \
  InstCombineAddSub.cpp \
  InstCombineAndOrXor.cpp \
  InstCombineCalls.cpp \
  InstCombineCasts.cpp \
  InstCombineCompares.cpp \
  InstCombineLoadStoreAlloca.cpp \
  InstCombineMulDivRem.cpp \
  InstCombinePHI.cpp \
  InstCombineSelect.cpp \
  InstCombineShifts.cpp \
  InstCombineSimplifyDemanded.cpp \
  InstCombineVectorOps.cpp

# For the host
# =====================================================
include $(CLEAR_VARS)

TBLGEN_TABLES80 := $(transforms_inst_combine_TBLGEN_TABLES80)
LOCAL_SRC_FILES := $(transforms_inst_combine_SRC_FILES)
LOCAL_MODULE:= libLLVM80InstCombine

LOCAL_MODULE_HOST_OS := darwin linux windows

include $(LLVM80_HOST_BUILD_MK)
include $(LLVM80_TBLGEN_RULES_MK)
include $(LLVM80_GEN_ATTRIBUTES_MK)
include $(LLVM80_GEN_INTRINSICS_MK)
include $(BUILD_HOST_STATIC_LIBRARY)

# For the device
# =====================================================
ifneq (true,$(DISABLE_LLVM_DEVICE_BUILDS))
include $(CLEAR_VARS)

TBLGEN_TABLES80 := $(transforms_inst_combine_TBLGEN_TABLES80)
LOCAL_SRC_FILES := $(transforms_inst_combine_SRC_FILES)
LOCAL_MODULE:= libLLVM80InstCombine

include $(LLVM80_DEVICE_BUILD_MK)
include $(LLVM80_TBLGEN_RULES_MK)
include $(LLVM80_GEN_ATTRIBUTES_MK)
include $(LLVM80_GEN_INTRINSICS_MK)
include $(BUILD_STATIC_LIBRARY)
endif
