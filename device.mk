#
# Copyright (C) 2011 Texas Instruments Inc.
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
#

# define OMAP_ENHANCEMENT variables
include device/ti/blaze_tablet/Config.mk

DEVICE_PACKAGE_OVERLAYS := device/ti/blaze_tablet/overlay

# Camera
PRODUCT_PACKAGES += \
    CameraOMAP \
    Camera \
    camera_test

PRODUCT_PACKAGES += \
    power.blaze_tablet

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/ti/blaze_tablet/boot/zImage
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

#Need to revisit the fastboot copy files
PRODUCT_COPY_FILES += \
	$(LOCAL_KERNEL):kernel \
	device/ti/blaze_tablet/init.tiomap4blazetablet.rc:root/init.tiomap4blazetablet.rc \
	device/ti/blaze_tablet/init.tiomap4blazetablet.usb.rc:root/init.tiomap4blazetablet.usb.rc \
	device/ti/blaze_tablet/ueventd.tiomap4blazetablet.rc:root/ueventd.tiomap4blazetablet.rc \
	device/ti/blaze_tablet/fstab.blaze_tablet:root/fstab.blaze_tablet \
	device/ti/blaze_tablet/qtouch-touchscreen.idc:system/usr/idc/qtouch-touchscreen.idc \
	device/ti/blaze_tablet/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
	device/ti/blaze_tablet/bootanimation.zip:/system/media/bootanimation.zip \
	device/ti/blaze_tablet/twl6030_pwrbutton.kl:system/usr/keylayout/twl6030_pwrbutton.kl \
	device/ti/blaze_tablet/media_profiles.xml:system/etc/media_profiles.xml \
	device/ti/blaze_tablet/media_codecs.xml:system/etc/media_codecs.xml \
	device/ti/common-open/audio/audio_policy.conf:system/etc/audio_policy.conf

# to mount the external storage (sdcard)
PRODUCT_COPY_FILES += \
        device/ti/blaze_tablet/vold.fstab:system/etc/vold.fstab

PRODUCT_PACKAGES += \
	lights.blaze_tablet

PRODUCT_PACKAGES += \
	sensors.blaze_tablet

PRODUCT_PACKAGES += \
	boardidentity \
	libboardidentity \
	libboard_idJNI \
	Board_id

PRODUCT_PACKAGES += \
	com.android.future.usb.accessory

PRODUCT_PROPERTY_OVERRIDES := \
	hwui.render_dirty_regions=false

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mtp

PRODUCT_CHARACTERISTICS := tablet

PRODUCT_PROPERTY_OVERRIDES += \
	ro.opengles.version=131072

PRODUCT_PROPERTY_OVERRIDES += \
	ro.sf.lcd_density=160

PRODUCT_PROPERTY_OVERRIDES += \
	persist.hwc.mirroring.region=0:0:1280:800

PRODUCT_TAGS += dalvik.gc.type-precise

# WI-Fi
PRODUCT_PACKAGES += \
	hostapd.conf \
	wifical.sh \
	wilink7.sh \
	TQS_D_1.7.ini \
	TQS_D_1.7_127x.ini \
	crda \
	regulatory.bin \
	calibrator

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0

# Filesystem management tools
PRODUCT_PACKAGES += \
	e2fsck \
	setup_fs

ifdef OMAP_ENHANCEMENT
# Audio HAL module
PRODUCT_PACKAGES += audio.primary.omap4
PRODUCT_PACKAGES += audio.hdmi.omap4
endif

# Bluetooth a2dp Audio HAL module
PRODUCT_PACKAGES += audio.a2dp.default

# Dolby DD+ Decoder
ifdef OMAP_ENHANCEMENT
PRODUCT_PACKAGES += \
        libstagefright_soft_ddpdec
endif

# Dolby Surround AudioEffects
ifdef OMAP_ENHANCEMENT
PRODUCT_PACKAGES += \
        libdseffect
endif

# Audioout libs
PRODUCT_PACKAGES += libaudioutils

# for bugmailer
PRODUCT_PACKAGES += send_bug
PRODUCT_COPY_FILES += \
	system/extras/bugmailer/bugmailer.sh:system/bin/bugmailer.sh \
	system/extras/bugmailer/send_bug:system/bin/send_bug

# tinyalsa utils
PRODUCT_PACKAGES += \
	tinymix \
	tinyplay \
	tinycap

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
	frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
	frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
	frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
	frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
	frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
	frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
	frameworks/base/nfc-extras/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfcextras.xml \
	device/ti/blaze_tablet/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	device/ti/blaze_tablet/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
	device/ti/blaze_tablet/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
	device/ti/omap5sevm/nfcee_access.xml:system/etc/nfcee_access.xml

# SMC components for secure services like crypto, secure storage
PRODUCT_PACKAGES += \
        smc_pa.ift \
        smc_normal_world_android_cfg.ini \
        libsmapi.so \
        libtf_crypto_sst.so \
        libtfsw_jce_provider.so \
        tfsw_jce_provider.jar \
        tfctrl

# Enable AAC 5.1 decode (decoder)
PRODUCT_PROPERTY_OVERRIDES += \
	media.aac_51_output_enabled=true

PRODUCT_PACKAGES += \
	blaze_tablet_hdcp_keys

$(call inherit-product, frameworks/native/build/tablet-dalvik-heap.mk)
$(call inherit-product, hardware/ti/omap4xxx/omap4.mk)
$(call inherit-product-if-exists, hardware/ti/wpan/ti-wpan-products.mk)
$(call inherit-product-if-exists, device/ti/proprietary-open/omap4/ti-omap4-vendor.mk)
$(call inherit-product-if-exists, device/ti/proprietary-open/wl12xx/wlan/wl12xx-wlan-fw-products.mk)
$(call inherit-product-if-exists, device/ti/common-open/s3d/s3d-products.mk)
$(call inherit-product-if-exists, device/ti/proprietary-open/omap4/ducati-blaze_tablet.mk)
$(call inherit-product-if-exists, device/ti/proprietary-open/omap4/dsp_fw.mk)
$(call inherit-product-if-exists, hardware/ti/dvp/dvp-products.mk)
$(call inherit-product-if-exists, hardware/ti/arx/arx-products.mk)

ifdef OMAP_ENHANCEMENT_CPCAM
$(call inherit-product-if-exists, device/ti/common-open/cpcam/cpcam-products.mk)
endif

# clear OMAP_ENHANCEMENT variables
$(call ti-clear-vars)
