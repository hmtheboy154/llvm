LOCAL_PATH := $(call my-dir)

AMDGPU_mc_desc_TBLGEN_TABLES := \
	AMDGPUGenRegisterInfo.inc \
	AMDGPUGenInstrInfo.inc \
	AMDGPUGenDAGISel.inc  \
	AMDGPUGenSubtargetInfo.inc \
	AMDGPUGenMCCodeEmitter.inc \
	AMDGPUGenCallingConv.inc \
	AMDGPUGenIntrinsics.inc \
	AMDGPUGenDFAPacketizer.inc \
	AMDGPUGenAsmWriter.inc

AMDGPU_mc_desc_SRC_FILES := \
  AMDGPUAsmBackend.cpp \
  AMDGPUELFObjectWriter.cpp \
  AMDGPUMCTargetDesc.cpp \
  AMDGPUMCAsmInfo.cpp \
  R600MCCodeEmitter.cpp \
  SIMCCodeEmitter.cpp

# For the host
# =====================================================
include $(CLEAR_VARS)
include $(CLEAR_TBLGEN_VARS)

LOCAL_MODULE:= libLLVMR600Desc

LOCAL_MODULE_TAGS := optional

LOCAL_MODULE_CLASS := STATIC_LIBRARIES

LOCAL_SRC_FILES := $(AMDGPU_mc_desc_SRC_FILES)

intermediates := $(call local-intermediates-dir)

LOCAL_C_INCLUDES := \
		$(LOCAL_PATH)/.. \
		$(intermediates)/../libLLVMCore_intermediates

TBLGEN_TABLES := $(AMDGPU_mc_desc_TBLGEN_TABLES)

TBLGEN_TD_DIR := $(LOCAL_PATH)/..

include $(LLVM_HOST_BUILD_MK)
include $(LLVM_TBLGEN_RULES_MK)
include $(LLVM_GEN_INTRINSICS_MK)
include $(BUILD_HOST_STATIC_LIBRARY)

# For the device only
# =====================================================
ifneq (true,$(DISABLE_LLVM_DEVICE_BUILDS))
include $(CLEAR_VARS)
include $(CLEAR_TBLGEN_VARS)

LOCAL_MODULE:= libLLVMR600Desc

LOCAL_MODULE_TAGS := optional

LOCAL_MODULE_CLASS := STATIC_LIBRARIES

LOCAL_SRC_FILES := $(AMDGPU_mc_desc_SRC_FILES)

intermediates := $(call local-intermediates-dir)

LOCAL_C_INCLUDES := \
		$(LOCAL_PATH)/.. \
		$(intermediates)/../libLLVMCore_intermediates \
		$(intermediates)/../libLLVMR600CodeGen_intermediates

TBLGEN_TABLES := $(AMDGPU_mc_desc_TBLGEN_TABLES)

TBLGEN_TD_DIR := $(LOCAL_PATH)/..

include $(LLVM_DEVICE_BUILD_MK)
include $(LLVM_TBLGEN_RULES_MK)
include $(LLVM_GEN_INTRINSICS_MK)
include $(BUILD_STATIC_LIBRARY)
endif
