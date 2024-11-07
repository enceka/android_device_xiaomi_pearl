#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from mt6895-common
$(call inherit-product, device/xiaomi/mt6895-common/mt6895.mk)

# Overlay
PRODUCT_PACKAGES += \
	FrameworksRes \
	NfcOverlay

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
	$(LOCAL_PATH)

# Keymaster
#PRODUCT_PACKAGES += \
	android.hardware.keymaster@3.0-service \
	android.hardware.keymaster@4.0-service \
	android.hardware.keymaster@4.1-service \
	libkeymaster4.vendor:64 \
	libkeymaster4support.vendor:64 \
	libkeymaster_portable.vendor:64 \
	libkeymaster_messages.vendor:64 \
	libsoft_attestation_cert.vendor:64 \
	libpuresoftkeymasterdevice.vendor:64

# FM Radio
#PRODUCT_PACKAGES += \
    FMRadio

# NFC
PRODUCT_PACKAGES += \
	com.android.nfc_extras \
	Tag

PRODUCT_PACKAGES += \
	android.hardware.nfc-service.nxp

$(eval PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/android.hardware.nfc.ese.xml \
	frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/android.hardware.nfc.hce.xml \
	frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/android.hardware.nfc.hcef.xml \
	frameworks/native/data/etc/android.hardware.nfc.uicc.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/android.hardware.nfc.uicc.xml \
	frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/android.hardware.nfc.xml \
	frameworks/native/data/etc/android.hardware.se.omapi.ese.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/android.hardware.se.omapi.ese.xml \
	frameworks/native/data/etc/android.hardware.se.omapi.uicc.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/android.hardware.se.omapi.uicc.xml \
	frameworks/native/data/etc/com.android.nfc_extras.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/com.android.nfc_extras.xml \
	frameworks/native/data/etc/com.nxp.mifare.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/com.nxp.mifare.xml)

# Rootdir
PRODUCT_PACKAGES += \
	init.pearl.rc

# Sensors
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/configs/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf

# Shipping API Level
PRODUCT_SHIPPING_API_LEVEL := 31

# Vndservice
PRODUCT_PACKAGES += \
	vndservice \
	vndservicemanager

# Inherit the proprietary files
$(call inherit-product, vendor/xiaomi/pearl/pearl-vendor.mk)
