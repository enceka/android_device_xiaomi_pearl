#!/bin/bash
#
# SPDX-FileCopyrightText: 2016 The CyanogenMod Project
# SPDX-FileCopyrightText: 2017-2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

DEVICE=pearl
VENDOR=xiaomi

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "${1}" in
        lib64/libsink.so)
            "${PATCHELF}" --add-needed "libshim_vtservice.so" "${2}"
            ;;
        vendor/lib/hw/mt6895/vendor.mediatek.hardware.pq@2.13-impl.so)
            ;&
        vendor/lib64/hw/mt6895/vendor.mediatek.hardware.pq@2.13-impl.so)
            "$PATCHELF" --replace-needed libutils.so libutils-v32.so "$2"
            ;;
        vendor/bin/hw/vendor.xiaomi.hardware.vibratorfeature.service)
            sed -i "s/\x00\x2F\x76\x69\x62\x72\x61\x74\x6F\x72\x66\x65\x61\x74\x75\x72\x65\x00/\x00\x2F\x64\x65\x66\x61\x75\x6C\x74\x00\x00\x00\x00\x00\x00\x00\x00\x00/g" "${2}"
            "${PATCHELF}" --replace-needed libutils.so libutils-v32.so "${2}"
            ;;
        vendor/etc/vintf/manifest/vendor.xiaomi.hardware.vibratorfeature.service.xml)
            sed -i "s/vibratorfeature/default/g" "${2}"
            ;;
        vendor/etc/init/android.hardware.neuralnetworks-shim-service-mtk.rc)
            sed -i 's/start/enable/' "$2"
            ;;
        vendor/bin/hw/vendor.mediatek.hardware.pq@2.2-service | vendor/bin/hw/mt6895/camerahalserver | vendor/bin/hw/android.hardware.thermal@2.0-service.mtk)
            "${PATCHELF}" --replace-needed libutils.so libutils-v32.so "${2}"
            ;;
        vendor/lib/mt6895/libmtkcam_stdutils.so | vendor/lib64/mt6895/libmtkcam_stdutils.so)
            "$PATCHELF" --replace-needed libutils.so libutils-v32.so "$2"
            ;;
        vendor/bin/hw/android.hardware.gnss-service.mediatek |\
        vendor/lib64/hw/android.hardware.gnss-impl-mediatek.so)
            "$PATCHELF" --replace-needed "android.hardware.gnss-V1-ndk_platform.so" "android.hardware.gnss-V1-ndk.so" "$2"
            ;;
        vendor/bin/hw/android.hardware.media.c2@1.2-mediatek | vendor/bin/hw/android.hardware.media.c2@1.2-mediatek-64b)
            "${PATCHELF}" --replace-needed "libavservices_minijail_vendor.so" "libavservices_minijail.so" "${2}"
            ;;
    esac
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"
