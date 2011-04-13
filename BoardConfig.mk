# Copyright (C) 2010 Texas Instruments Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# BoardConfig.mk
#
# Product-specific compile-time definitions.
#

OMAP_ENHANCEMENT := true
# Use the non-open-source parts: Example: graphics, bt-firmware etc
#-include vendor/ti/blaze_tablet/BoardConfigVendor.mk

TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi

BOARD_HAVE_BLUETOOTH := true


TARGET_NO_BOOTLOADER := true

#TODO: needed for boot.img auto-creation: disble for now
TARGET_NO_KERNEL := false
TARGET_NO_RECOVERY := true

TARGET_NO_RADIOIMAGE := true
TARGET_PROVIDES_INIT_TARGET_RC := true
TARGET_BOARD_PLATFORM := omap4
TARGET_BOOTLOADER_BOARD_NAME := omap4sdp

TARGET_SEC_INTERNAL_STORAGE := false

# Enable NEON feature
TARGET_ARCH_VARIANT := armv7-a-neon
ARCH_ARM_HAVE_TLS_REGISTER := true

USE_CAMERA_STUB := true
ifeq ($(USE_CAMERA_STUB),false)
BOARD_CAMERA_LIBRARIES := libcamera
endif


# kernel
ifeq ($(TARGET_NO_KERNEL),false)
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_CMDLINE := console=ttyO2,115200n8 mem=456M@0x80000000 mem=512M@0xA0000000 init=/init vram=20M omapfb.vram=0:8M androidboot.hardware=omap4430 androidboot.console=ttyO2
endif

# Recovery
ifeq ($(TARGET_NO_RECOVERY),false)
TARGET_RECOVERY_UI_LIB := librecovery_ui_blaze_tablet
TARGET_RELEASETOOLS_EXTENSIONS := device/ti/blaze_tablet
endif

# File system
TARGET_USERIMAGES_USE_EXT4 := true
#TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 536870912
BOARD_USERDATAIMAGE_PARTITION_SIZE := 536870912
BOARD_FLASH_BLOCK_SIZE := 4096


# Connectivity - Wi-Fi
USES_TI_WL1283 := true
BOARD_WPA_SUPPLICANT_DRIVER := CUSTOM
ifdef USES_TI_WL1283
BOARD_WLAN_DEVICE           := wl1283
BOARD_SOFTAP_DEVICE         := wl1283
endif
WPA_SUPPLICANT_VERSION      := VER_0_6_X
HOSTAPD_VERSION             := VER_0_6_X
WIFI_DRIVER_MODULE_PATH     := "/system/etc/wifi/tiwlan_drv.ko"
WIFI_DRIVER_MODULE_NAME     := "tiwlan_drv"
WIFI_FIRMWARE_LOADER        := "wlan_loader"

# Sensors
#BOARD_HAVE_SENSORS := true

# FM
#BUILD_FM_RADIO := true
#FM_CHR_DEV_ST := true
#BOARD_HAVE_FM_ROUTING := true

# MultiMedia defines
#BOARD_USES_GENERIC_AUDIO := true
BOARD_USES_ALSA_AUDIO := true
BUILD_WITH_ALSA_UTILS := true
#BOARD_USES_TI_CAMERA_HAL := true
#HARDWARE_OMX := true
#FW3A := true
#ICAP := true
#IMAGE_PROCESSING_PIPELINE := true 
ifdef HARDWARE_OMX
OMX_VENDOR := ti
OMX_VENDOR_INCLUDES := \
   hardware/ti/omx/system/src/openmax_il/omx_core/inc \
   hardware/ti/omx/image/src/openmax_il/jpeg_enc/inc
OMX_VENDOR_WRAPPER := TI_OMX_Wrapper
BOARD_OPENCORE_LIBRARIES := libOMX_Core
BOARD_OPENCORE_FLAGS := -DHARDWARE_OMX=1
endif

ifdef OMAP_ENHANCEMENT
COMMON_GLOBAL_CFLAGS += -DOMAP_ENHANCEMENT -DTARGET_OMAP4
endif

# This define enables the compilation of OpenCore's command line TestApps
#BUILD_PV_TEST_APPS :=1

# Enable Audio Modem
#BOARD_USES_TI_OMAP_MODEM_AUDIO := true
