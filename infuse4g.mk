# Copyright (C) 2010 The Android Open Source Project
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


# This file is the device-specific product definition file for
# crespo. It lists all the overlays, files, modules and properties
# that are specific to this hardware: i.e. those are device-specific
# drivers, configuration files, settings, etc...

# Note that crespo is not a fully open device. Some of the drivers
# aren't publicly available in all circumstances, which means that some
# of the hardware capabilities aren't present in builds where those
# drivers aren't available. Such cases are handled by having this file
# separated into two halves: this half here contains the parts that
# are available to everyone, while another half in the vendor/ hierarchy
# augments that set with the parts that are only relevant when all the
# associated drivers are available. Aspects that are irrelevant but
# harmless in no-driver builds should be kept here for simplicity and
# transparency. There are two variants of the half that deals with
# the unavailable drivers: one is directly checked into the unreleased
# vendor tree and is used by engineers who have access to it. The other
# is generated by setup-makefile.sh in the same directory as this files,
# and is used by people who have access to binary versions of the drivers
# but not to the original vendor tree. Be sure to update both.


# These is the hardware-specific overlay, which points to the location
# of hardware-specific resource overrides, typically the frameworks and
# application settings that are stored in resourced.
DEVICE_PACKAGE_OVERLAYS := device/samsung/infuse4g/overlay

# These are the hardware-specific configuration files
PRODUCT_COPY_FILES := \
	device/samsung/infuse4g/prebuilt/etc/vold.fstab:system/etc/vold.fstab \
	device/samsung/infuse4g/prebuilt/lib/egl/egl.cfg:system/lib/egl/egl.cfg \
	device/samsung/infuse4g/prebuilt/usr/idc/sec_touchscreen.idc:system/usr/idc/sec_touchscreen.idc \
	device/samsung/infuse4g/prebuilt/usr/idc/melfas_touchkey.idc:system/usr/idc/melfas_touchkey.idc

# Init files
PRODUCT_COPY_FILES += \
	device/samsung/infuse4g/init.aries.rc:root/init.aries.rc \
	device/samsung/infuse4g/init.aries.usb.rc:root/init.aries.usb.rc \
	device/samsung/infuse4g/init.aries.usb.rc:recovery/root/usb.rc \
	device/samsung/infuse4g/ueventd.aries.rc:root/ueventd.aries.rc \
	device/samsung/infuse4g/fstab.aries:root/fstab.aries \
	device/samsung/infuse4g/lpm.rc:root/lpm.rc

# Prebuilt kl keymaps
PRODUCT_COPY_FILES += \
	device/samsung/infuse4g/prebuilt/usr/keylayout/aries-keypad.kl:system/usr/keylayout/aries-keypad.kl \
	device/samsung/infuse4g/prebuilt/usr/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
	device/samsung/infuse4g/prebuilt/usr/keylayout/Broadcom_Bluetooth_HID.kl:system/usr/keylayout/Broadcom_Bluetooth_HID.kl \
	device/samsung/infuse4g/prebuilt/usr/keylayout/melfas_touchkey.kl:system/usr/keylayout/melfas_touchkey.kl \
	device/samsung/infuse4g/prebuilt/usr/keylayout/sec_jack.kl:system/usr/keylayout/sec_jack.kl

# Generated kcm keymaps
PRODUCT_PACKAGES := \
	aries-keypad.kcm \
	Broadcom_Bluetooth_HID.kcm \
	melfas_touchkey.kcm

# Filesystem management tools
PRODUCT_PACKAGES += \
	make_ext4fs \
	setup_fs \
	bml_over_mtd

# These are the OpenMAX IL configuration files
PRODUCT_COPY_FILES += \
	hardware/samsung/exynos3/s5pc110/sec_mm/sec_omx/sec_omx_core/secomxregistry:system/etc/secomxregistry \
	device/samsung/aries-common/media_profiles.xml:system/etc/media_profiles.xml \
	device/samsung/aries-common/media_codecs.xml:system/etc/media_codecs.xml

# These are the OpenMAX IL modules
PRODUCT_PACKAGES += \
	libSEC_OMX_Core \
	libOMX.SEC.AVC.Decoder \
	libOMX.SEC.M4V.Decoder \
	libOMX.SEC.M4V.Encoder \
	libOMX.SEC.AVC.Encoder

PRODUCT_PACKAGES += \
	audio.primary.aries \
	audio.a2dp.default \
	audio.usb.default \
	sensors.aries \
	lights.aries \
	power.s5pc110

PRODUCT_COPY_FILES += \
	device/samsung/infuse4g/libaudio/audio_policy.conf:system/etc/audio_policy.conf

# Charger
PRODUCT_PACKAGES += \
    charger \
    charger_res_images

# Libs
PRODUCT_PACKAGES += \
	hwcomposer.s5pc110 \
	libstagefrighthw

# Camera
PRODUCT_PACKAGES += \
	camera.aries \
	libs3cjpeg

# Bluetooth MAC Address
PRODUCT_PACKAGES += \
	bdaddr_read

# Service Mode Secret Code
PRODUCT_PACKAGES += \
	SamsungServiceMode

# Infuse Settings
PRODUCT_PACKAGES += \
	InfuseSettings

# Missed apps
PRODUCT_PACKAGES += \
	Torch

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
	frameworks/native/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
	frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
	frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES := \
	ro.opengles.version=131072

# These are the hardware-specific settings that are stored in system properties.
# Note that the only such settings should be the ones that are too low-level to
# be reachable from resources or other mechanisms.
PRODUCT_PROPERTY_OVERRIDES += \
       wifi.interface=wlan0 \
       wifi.supplicant_scan_interval=120 \
       ro.telephony.ril_class=SamsungExynos3RIL \
       ro.telephony.ril.v3=icccardstatus,datacall,signalstrength,facilitylock \
       mobiledata.interfaces=pdp0,wlan0,gprs,ppp0 \
       persist.sys.vold.switchexternal=1

# dpi
PRODUCT_PROPERTY_OVERRIDES += \
	ro.sf.lcd_density=240

# enable Google-specific location features,
# like NetworkLocationProvider and LocationCollector
PRODUCT_PROPERTY_OVERRIDES += \
        ro.com.google.locationfeatures=1 \
        ro.com.google.networklocation=1

# Extended JNI checks
# The extended JNI checks will cause the system to run more slowly, but they can spot a variety of nasty bugs 
# before they have a chance to cause problems.
# Default=true for development builds, set by android buildsystem.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.kernel.android.checkjni=0 \
    dalvik.vm.checkjni=false

# Override /proc/sys/vm/dirty_ratio on UMS
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vold.umsdirtyratio=20

# enable repeatable keys in cwm
PRODUCT_PROPERTY_OVERRIDES +=\
    ro.cwm.enable_key_repeat=true

# We have sacrificed /cache for a larger /system, so it's not large enough for dalvik cache
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dexopt-data-only=1

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mass_storage

include frameworks/native/build/phone-hdpi-512-dalvik-heap.mk

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_COPY_FILES += \
    device/samsung/infuse4g/updater.sh:updater.sh


# See comment at the top of this file. This is where the other
# half of the device-specific product definition file takes care
# of the aspects that require proprietary drivers that aren't
# commonly available
$(call inherit-product-if-exists, vendor/samsung/infuse4g/infuse4g-vendor.mk)
