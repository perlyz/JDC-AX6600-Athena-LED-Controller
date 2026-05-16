include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-athena-led
PKG_VERSION:=2.2.4
PKG_RELEASE:=1

PKG_MAINTAINER:=perlyz <https://github.com/perlyz>, unraveloop <https://github.com/unraveloop>
PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_BUILD_DEPENDS:=rust/host luci-base/host
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/rust/rust-package.mk

define Package/$(PKG_NAME)
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI support for Athena LED
	URL:=https://github.com/perlyz/JDC-AX6600-Athena-LED-Controller
	DEPENDS:=$(RUST_ARCH_DEPENDS) +lua +luci-base
endef

define Package/$(PKG_NAME)/description
 LuCI support for the JDCloud AX6600 Athena LED controller.
 Builds the Rust backend from the bundled source tree instead of
 downloading a prebuilt release artifact.
endef

define Build/Prepare
	rm -rf $(PKG_BUILD_DIR)
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./LICENSE $(PKG_BUILD_DIR)/
	$(CP) ./athena-led $(PKG_BUILD_DIR)/
	$(CP) ./luci-app-athena-led $(PKG_BUILD_DIR)/
endef

define Build/Compile
	$(call Build/Compile/Cargo,athena-led)
	[ -d $(PKG_BUILD_DIR)/luci-app-athena-led/po/zh_Hans ] && po2lmo \
		$(PKG_BUILD_DIR)/luci-app-athena-led/po/zh_Hans/athena_led.po \
		$(PKG_BUILD_DIR)/zh_Hans.lmo || true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci
	$(CP) $(PKG_BUILD_DIR)/luci-app-athena-led/luasrc/* $(1)/usr/lib/lua/luci/

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/luci-app-athena-led/root/etc/init.d/athena_led $(1)/etc/init.d/

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/luci-app-athena-led/root/etc/config/athena_led $(1)/etc/config/

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/athena-led $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/luci-app-athena-led/root/usr/bin/find_button.sh $(1)/usr/bin/find_button

	$(INSTALL_DIR) $(1)/etc/athena_led/anim
	$(CP) $(PKG_BUILD_DIR)/luci-app-athena-led/root/etc/athena_led/anim/*.bin $(1)/etc/athena_led/anim/ 2>/dev/null || true

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	[ -f $(PKG_BUILD_DIR)/zh_Hans.lmo ] && { \
		$(INSTALL_DATA) $(PKG_BUILD_DIR)/zh_Hans.lmo $(1)/usr/lib/lua/luci/i18n/athena_led.zh-cn.lmo; \
		$(INSTALL_DATA) $(PKG_BUILD_DIR)/zh_Hans.lmo $(1)/usr/lib/lua/luci/i18n/athena_led.zh_Hans.lmo; \
	} || true
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	if [ -f /etc/config/athena_led.apk-new ]; then
		mv /etc/config/athena_led /etc/config/athena_led.v1_bak 2>/dev/null
		mv /etc/config/athena_led.apk-new /etc/config/athena_led
	fi
	if [ -f /etc/config/athena_led-opkg ]; then
		mv /etc/config/athena_led /etc/config/athena_led.v1_bak 2>/dev/null
		mv /etc/config/athena_led-opkg /etc/config/athena_led
	fi
	rm -rf /tmp/luci-indexcache /tmp/luci-modulecache/* 2>/dev/null
	/etc/init.d/athena_led restart >/dev/null 2>&1
fi
exit 0
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
