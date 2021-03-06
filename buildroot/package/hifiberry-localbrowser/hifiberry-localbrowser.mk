################################################################################
#
# hifiberry-localbrowser
#
################################################################################


define HIFIBERRY_LOCALBROWSER_BUILD_CMDS
endef

define HIFIBERRY_LOCALBROWSER_INSTALL_TARGET_CMDS
    # Weston config
    install -D -m 644 $(BR2_EXTERNAL_HIFIBERRY_PATH)/package/hifiberry-localbrowser/weston.ini \
            $(TARGET_DIR)/etc/xdg/weston/weston.ini

endef

define HIFIBERRY_LOCALBROWSER_INSTALL_INIT_SYSTEMD
    $(INSTALL) -D -m 0644 $(BR2_EXTERNAL_HIFIBERRY_PATH)/package/hifiberry-localbrowser/weston.service \
           $(TARGET_DIR)/usr/lib/systemd/system/weston.service
    ln -fs ../../../../usr/lib/systemd/system/weston.service \
           $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/weston.service
    $(INSTALL) -D -m 0644 $(BR2_EXTERNAL_HIFIBERRY_PATH)/package/hifiberry-localbrowser/cog.service \
           $(TARGET_DIR)/usr/lib/systemd/system/cog.service
    ln -fs ../../../../usr/lib/systemd/system/cog.service \
           $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/cog.service
endef

$(eval $(generic-package))
