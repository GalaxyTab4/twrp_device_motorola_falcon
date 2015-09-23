#
# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# call the proprietary setup
#$(call inherit-product, vendor/motorola/falcon/falcon-vendor.mk)

# Overlay
# DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

ifeq ($(TARGET_PREBUILT_KERNEL),)
  LOCAL_KERNEL := device/motorola/falcon/kernel
else
  LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# TWRP
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/twrp.fstab:recovery/root/etc/twrp.fstab

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/curtain.jpg:recovery/root/twres/images/curtain.jpg

# Ramdisk
# PRODUCT_PACKAGES += \
#    fstab.qcom \
#    init.target.rc

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

# Inherit from msm8226-common
#$(call inherit-product, device/motorola/msm8226-common/msm8226.mk)
