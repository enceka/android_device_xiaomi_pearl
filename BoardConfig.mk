#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Platform
TARGET_BOARD_PLATFORM := mt6895
BOARD_HAS_MTK_HARDWARE := true
BOARD_VENDOR := xiaomi
DEVICE_PATH := device/xiaomi/pearl
BOARD_TEE_VARIANT ?= mitee

# Inherit from mt6895-common
include device/xiaomi/mt6895-common/BoardConfigCommon.mk

# Kernel
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
# Common Kernel
TARGET_KERNEL_SOURCE := kernel/xiaomi/mt6895
# Pearl S OSS
#TARGET_KERNEL_SOURCE := kernel/xiaomi/pearl
TARGET_KERNEL_CLANG_VERSION := r416183b
TARGET_KERNEL_CLANG_PATH := $(abspath .)/prebuilts/clang/kernel/$(HOST_PREBUILT_TAG)/clang-$(TARGET_KERNEL_CLANG_VERSION)
#TARGET_KERNEL_CONFIG := \
	gki_defconfig \
	xiaomi_mt6895.config \
	pearl.config
TARGET_KERNEL_CONFIG := \
	gki_defconfig \
	vendor/xiaomi_mt6895.config \
	vendor/$(PRODUCT_DEVICE).config

TARGET_KERNEL_DTB := \
    vendor/mediatek/mt6895.dtb

BOARD_KERNEL_IMAGE_NAME := Image.gz
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules/modules.load.vendor_boot))
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules/modules.load.recovery))
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules/modules.load))
BOOT_KERNEL_MODULES := $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD) $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD)

# Allow copy files
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Kernel (prebuilt)
#TARGET_KERNEL_ARCH := arm64
#TARGET_KERNEL_HEADER_ARCH := arm64
#TARGET_FORCE_PREBUILT_KERNEL := true
#BOARD_USES_GENERIC_KERNEL_IMAGE := true
#TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/kernel/kernel
#TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilts/kernel/dtb
#BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
#BOARD_INCLUDE_DTB_IN_BOOTIMG := 
#BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilts/kernel/dtbo.img
#BOARD_KERNEL_SEPARATED_DTBO := 

# Display
TARGET_SCREEN_DENSITY := 392

# HIDL
ODM_MANIFEST_FILES := $(DEVICE_PATH)/manifest_pearl.xml

# Platform
#BOARD_HAVE_MTK_FM := true

# Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Security Patch Level
VENDOR_SECURITY_PATCH := 2024-08-01

# Inherit the proprietary files
include vendor/xiaomi/pearl/BoardConfigVendor.mk
