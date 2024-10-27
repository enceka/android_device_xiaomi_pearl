#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from mt6895-common
$(call inherit-product, device/xiaomi/mt6895-common/mt6895.mk)

# Overlay
PRODUCT_PACKAGES += \
    FrameworksResPearl

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Rootdir
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/init.pearl.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.pearl.rc

# Shipping API Level
PRODUCT_SHIPPING_API_LEVEL := 31

# Inherit the proprietary files
$(call inherit-product, vendor/xiaomi/pearl/pearl-vendor.mk)
