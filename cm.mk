# Release name
PRODUCT_RELEASE_NAME := Infuse4G

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/infuse4g/full_infuse4g.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := infuse4g
PRODUCT_NAME := cm_infuse4g
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SGH-I997

#Set build fingerprint / ID / Product Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=SGH-I997 TARGET_DEVICE=SGH-I997 BUILD_FINGERPRINT=samsung/SGH-I997/SGH-I997:2.3.5/GINGERBREAD/UCKJ1:user/release-keys PRIVATE_BUILD_DESC="SGH-I997-user 2.3.5 GINGERBREAD UCKJ1 release-keys"

