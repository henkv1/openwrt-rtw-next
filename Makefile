include $(TOPDIR)/rules.mk

PKG_NAME:=rtw88
PKG_RELEASE:=2

PKG_LICENSE:=GPLv2
PKG_LICENSE_FILES:=

#PKG_SOURCE_URL:=https://github.com/lwfinger/rtw88
#PKG_SOURCE_PROTO:=git
#PKG_SOURCE_VERSION:=764a1ee307d7e5720a93b8139c94d76737eced91
SOURCE_DIR=src

# PKG_MAINTAINER:=
PKG_BUILD_PARALLEL:=1

STAMP_CONFIGURED_DEPENDS := $(STAGING_DIR)/usr/include/mac80211-backport/backport/autoconf.h

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

PKG_DRIVERS += \
        rtw88 rtw88-pci rtw88-usb rtw88-sdio rtw88-8821c rtw88-8822b rtw88-8822c \
        rtw88-8723d rtw88-8821ce rtw88-8821cu rtw88-8822be rtw88-8822bu \
        rtw88-8822ce rtw88-8822cu rtw88-8723de rtw88-8723ds rtw88-8723du

config-y += STAGING

config-$(call config_package,rtw88) += RTW88 RTW88_CORE
config-$(call config_package,rtw88-pci) += RTW88_PCI
config-$(call config_package,rtw88-usb) += RTW88_USB
config-$(call config_package,rtw88-sdio) += RTW88_SDIO
config-$(call config_package,rtw88-8821c) += RTW88_8821C
config-$(call config_package,rtw88-8821ce) += RTW88_8821CE
config-$(call config_package,rtw88-8821cu) += RTW88_8821CU
config-$(call config_package,rtw88-8822b) += RTW88_8822B
config-$(call config_package,rtw88-8822be) += RTW88_8822BE
config-$(call config_package,rtw88-8822bu) += RTW88_8822BU
config-$(call config_package,rtw88-8822c) += RTW88_8822C
config-$(call config_package,rtw88-8822ce) += RTW88_8822CE
config-$(call config_package,rtw88-8822cu) += RTW88_8822CU
config-$(call config_package,rtw88-8723d) += RTW88_8723D
config-$(call config_package,rtw88-8723de) += RTW88_8723DE
config-$(call config_package,rtw88-8723ds) += RTW88_8723DS
config-$(call config_package,rtw88-8723du) += RTW88_8723DU
config-$(CONFIG_PACKAGE_RTW88_DEBUG) += RTW88_DEBUG
config-$(CONFIG_PACKAGE_RTW88_DEBUGFS) += RTW88_DEBUGFS

define KernelPackage/rtw88
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTW88 common part
  DEPENDS+= +kmod-mac80211
  FILES:=$(PKG_BUILD_DIR)/rtw88_core.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_core)
  HIDDEN:=1
endef

define KernelPackage/rtw88-usb
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTW88 USB chips support
  DEPENDS+= @USB_SUPPORT +kmod-rtw88 +kmod-usb-core
  FILES:=$(PKG_BUILD_DIR)/rtw88_usb.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_usb)
  HIDDEN:=1
endef

define KernelPackage/rtw88-8821c
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8821C family support
  DEPENDS+= +kmod-rtw88 +rtl8821ce-firmware +@DRIVER_11AC_SUPPORT
  FILES:=$(PKG_BUILD_DIR)/rtw88_8821c.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_8821c)
  HIDDEN:=1
endef

define KernelPackage/rtw88-8822b
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8822B family support
  DEPENDS+= +kmod-rtw88 +rtl8822be-firmware +@DRIVER_11AC_SUPPORT
  FILES:=$(PKG_BUILD_DIR)/rtw88_8822b.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_8822b)
  HIDDEN:=1
endef

define KernelPackage/rtw88-8822c
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8822C family support
  DEPENDS+= +kmod-rtw88 +rtl8822ce-firmware +@DRIVER_11AC_SUPPORT
  FILES:=$(PKG_BUILD_DIR)/rtw88_8822c.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_8822c)
  HIDDEN:=1
endef

define KernelPackage/rtw88-8821cu
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8821CU support
  DEPENDS+= +kmod-rtw88-usb +kmod-rtw88-8821c
  FILES:=$(PKG_BUILD_DIR)/rtw88_8821cu.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_8821cu)
endef

define KernelPackage/rtw88-8822bu
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8822BU support
  DEPENDS+= +kmod-rtw88-usb +kmod-rtw88-8822b
  FILES:=$(PKG_BUILD_DIR)/rtw88_8822bu.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_8822bu)
endef
define KernelPackage/rtw88-8822cu
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8822CU support
  DEPENDS+= +kmod-rtw88-usb +kmod-rtw88-8822c
  FILES:=$(PKG_BUILD_DIR)/rtw88_8822cu.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_8822cu)
endef

NOSTDINC_FLAGS = \
	-I$(PKG_BUILD_DIR) \
	-I$(PKG_BUILD_DIR)/include \
	-I$(STAGING_DIR)/usr/include/mac80211-backport \
	-I$(STAGING_DIR)/usr/include/mac80211-backport/uapi \
	-I$(STAGING_DIR)/usr/include/mac80211 \
	-I$(STAGING_DIR)/usr/include/mac80211/uapi \
	-include backport/autoconf.h \
	-include backport/backport.h

EXTRA_CFLAGS:= \
	-DRTW_SINGLE_WIPHY \
	-DRTW_USE_CFG80211_STA_EVENT \
	-DCONFIG_IOCTL_CFG80211 \
	-DCONFIG_CONCURRENT_MODE \
	-DBUILD_OPENWRT

EXTRA_KCONFIG:= \
	CONFIG_RTW88-USB=m \
	USER_MODULE_NAME=rtw88-usb

MAKE_OPTS:= \
	$(KERNEL_MAKE_FLAGS) \
	M="$(PKG_BUILD_DIR)" \
	NOSTDINC_FLAGS="$(NOSTDINC_FLAGS)" \
	USER_EXTRA_CFLAGS="$(EXTRA_CFLAGS)" \
	$(EXTRA_KCONFIG)

define Build/Compile
	+$(MAKE) $(PKG_JOBS) -C "$(LINUX_DIR)" \
		$(MAKE_OPTS) \
		modules
endef

define Package/rtw88-firmware/install
	$(INSTALL_DIR) $(1)/lib/firmware/rtw88
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/firmware/* \
		$(1)/lib/firmware/rtw88/
endef

$(eval $(call KernelPackage,rtw88))
$(eval $(call KernelPackage,rtw88-usb))
$(eval $(call KernelPackage,rtw88-8822b))
$(eval $(call KernelPackage,rtw88-8822bu))
$(eval $(call KernelPackage,rtw88-8821c))
$(eval $(call KernelPackage,rtw88-8821c))
$(eval $(call KernelPackage,rtw88-8822cu))
$(eval $(call KernelPackage,rtw88-8822cu))
