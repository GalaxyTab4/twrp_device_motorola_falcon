# Release name
PRODUCT_RELEASE_NAME := falcon

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/motorola/falcon/device.mk)

# Device identifier - this must come after all inclusions
PRODUCT_DEVICE := falcon
PRODUCT_NAME := cm_falcon
PRODUCT_BRAND := motorola
PRODUCT_MODEL := MOTO G
PRODUCT_MANUFACTURER := Motorola
