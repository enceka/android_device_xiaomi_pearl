#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from generic device
$(call inherit-product, device/xiaomi/pearl/device.mk)

PRODUCT_DEVICE := pearl
PRODUCT_NAME := lineage_pearl
PRODUCT_BRAND := Redmi
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_MODEL := 23054RA19C

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="pearl-user 14 UP1A.231005.007 V816.0.6.0.ULHCNXM release-keys"

BUILD_FINGERPRINT := Redmi/pearl/pearl:14/UP1A.231005.007/V816.0.6.0.ULHCNXM:user/release-keys
