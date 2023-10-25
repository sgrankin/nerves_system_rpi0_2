SHARP_DRM_BASE = $(NERVES_DEFCONFIG_DIR)/packages/sharp-drm
SHARP_DRM_VERSION = fc7ba64cdc10d289933aa83e2c3f98f99403dc4c
SHARP_DRM_SITE = https://github.com/sgrankin/sharp-drm-driver.git
SHARP_DRM_SITE = $(call github,sgrankin,sharp-drm-driver,$(SHARP_DRM_VERSION))

SHARP_DRM_INSTALL_IMAGES = YES

define SHARP_DRM_BUILD_CMDS
	$(HOST_DIR)/bin/dtc -@ -I dts -O dtb -W no-unit_address_vs_reg -o $(@D)/sharp-drm.dtbo $(@D)/sharp-drm.dts;
endef

define SHARP_DRM_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 $(@D)/sharp-drm.dtbo $(BINARIES_DIR)/rpi-firmware/overlays;
endef

$(eval $(kernel-module))
$(eval $(generic-package))
