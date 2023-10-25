BEEPY_KBD_BASE = $(NERVES_DEFCONFIG_DIR)/packages/beepy-kbd
BEEPY_KBD_VERSION = 014545bb5cee5da22ee67165cf35d96d197ec82a
BEEPY_KBD_SITE = $(call github,ardangelo,beepberry-keyboard-driver,$(BEEPY_KBD_VERSION))

BEEPY_KBD_INSTALL_IMAGES = YES

define BEEPY_KBD_BUILD_CMDS
	for dts in $(@D)/*.dts; do \
		$(HOST_DIR)/bin/dtc -@ -I dts -O dtb -W no-unit_address_vs_reg -o $${dts%.dts}.dtbo $${dts}; \
	done
endef

define BEEPY_KBD_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(@D)/beepy-kbd.map $(TARGET_DIR)/usr/share/keymaps/;
endef

define BEEPY_KBD_INSTALL_IMAGES_CMDS
	for dtbo in $(@D)/*.dtbo; do \
		$(INSTALL) -D -m 0644 $${dtbo} $(BINARIES_DIR)/rpi-firmware/overlays; \
	done
endef

$(eval $(kernel-module))
$(eval $(generic-package))
