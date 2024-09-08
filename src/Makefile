SHELL := /bin/sh
KVER ?= $(if $(KERNELRELEASE),$(KERNELRELEASE),$(shell uname -r))
KSRC ?= $(if $(KERNEL_SRC),$(KERNEL_SRC),/lib/modules/$(KVER)/build)
FIRMWAREDIR := /lib/firmware/
PWD := $(shell pwd)
CLR_MODULE_FILES := *.mod.c *.mod *.o .*.cmd *.ko *~ .tmp_versions* modules.order Module.symvers
SYMBOL_FILE := Module.symvers
# Handle the move of the entire rtw88 tree
ifneq ("","$(wildcard /lib/modules/$(KVER)/kernel/drivers/net/wireless/realtek)")
MODDESTDIR := /lib/modules/$(KVER)/kernel/drivers/net/wireless/realtek/rtw88
else
MODDESTDIR := /lib/modules/$(KVER)/kernel/drivers/net/wireless/rtw88
endif

ifneq ("$(INSTALL_MOD_PATH)", "")
DEPMOD_ARGS = -b $(INSTALL_MOD_PATH)
else
DEPMOD_ARGS =
endif

#Handle the compression option for modules in 3.18+
ifneq ("","$(wildcard $(MODDESTDIR)/*.ko.gz)")
COMPRESS_GZIP := y
endif
ifneq ("","$(wildcard $(MODDESTDIR)/*.ko.xz)")
COMPRESS_XZ := y
endif
ifneq ("","$(wildcard $(MODDESTDIR)/*.ko.zst)")
COMPRESS_ZSTD := y
endif

ifeq ("","$(wildcard MOK.der)")
NO_SKIP_SIGN := y
endif

EXTRA_CFLAGS += -O2
ifeq ($(CONFIG_PCI), y)
EXTRA_CFLAGS += -DCONFIG_RTW88_8822BE=1
EXTRA_CFLAGS += -DCONFIG_RTW88_8821CE=1
EXTRA_CFLAGS += -DCONFIG_RTW88_8822CE=1
EXTRA_CFLAGS += -DCONFIG_RTW88_8723DE=1
endif
#EXTRA_CFLAGS += -DCONFIG_RTW88_REGD_USER_REG_HINTS

obj-m	+= rtw88_core.o
rtw88_core-objs += main.o \
	   mac80211.o \
	   util.o \
	   debug.o \
	   tx.o \
	   rx.o \
	   mac.o \
	   phy.o \
	   coex.o \
	   efuse.o \
	   fw.o \
	   ps.o \
	   sec.o \
	   wow.o \
	   bf.o \
	   regd.o \
	   sar.o

obj-m       += rtw88_8821c.o
rtw88_8821c-objs                := rtw8821c.o rtw8821c_table.o

obj-m       += rtw88_8822b.o
rtw88_8822b-objs                := rtw8822b.o rtw8822b_table.o

ifeq ($(CONFIG_PCI), y)
obj-m      += rtw88_8822be.o
rtw88_8822be-objs               := rtw8822be.o
endif

obj-m      += rtw88_8822bu.o
rtw88_8822bu-objs		:= rtw8822bu.o

obj-m       += rtw88_8822c.o
rtw88_8822c-objs                := rtw8822c.o rtw8822c_table.o


obj-m      += rtw88_8822cu.o
rtw88_8822cu-objs		:= rtw8822cu.o

obj-m	+= rtw88_8821cu.o
rtw88_8821cu-objs		:= rtw8821cu.o

obj-m			+= rtw88_usb.o
rtw88_usb-objs		:= usb.o

ccflags-y += -D__CHECK_ENDIAN__

all: 
	$(MAKE) -C $(KSRC) M=$(PWD) modules
install: all
	@mkdir -p $(MODDESTDIR)
	@install -p -D -m 644 *.ko $(MODDESTDIR)	
	@#copy firmware images to target folder
	@mkdir -p $(FIRMWAREDIR)/rtw88/
	@cp -f *.bin $(FIRMWAREDIR)/rtw88/
ifeq ($(COMPRESS_GZIP), y)
	@gzip -f $(MODDESTDIR)/*.ko
endif
ifeq ($(COMPRESS_XZ), y)
	@xz -f -C crc32 $(MODDESTDIR)/*.ko
endif
ifeq ($(COMPRESS_ZSTD), y)
	@zstd -f -q --rm $(MODDESTDIR)/*.ko
endif

	@depmod $(DEPMOD_ARGS) -a $(KVER)

	@echo "Install rtw88 SUCCESS"



uninstall:
	modprobe -r rtw_8723cs
ifeq ($(CONFIG_PCI), y)
	modprobe -r rtw_8723de
endif
	modprobe -r rtw_8723ds
	modprobe -r rtw_8723du
	modprobe -r rtw_8812au
	modprobe -r rtw_8821au
ifeq ($(CONFIG_PCI), y)
	modprobe -r rtw_8821ce
endif
	modprobe -r rtw_8821cs
	modprobe -r rtw_8821cu
ifeq ($(CONFIG_PCI), y)
	modprobe -r rtw_8822be
endif
	modprobe -r rtw_8822bs
	modprobe -r rtw_8822bu
ifeq ($(CONFIG_PCI), y)
	modprobe -r rtw_8822ce
endif
	modprobe -r rtw_8822cs
	modprobe -r rtw_8822cu
	
	rm -f $(MODDESTDIR)/rtw_*.ko*
	
	depmod $(DEPMOD_ARGS)
	
	@echo "Uninstall rtw88 SUCCESS"

clean:
	@rm -fr *.mod.c *.mod *.cmd *.o .*.cmd *.ko *~ .*.o.d .cache.mk
	@rm -fr .tmp_versions
	@rm -fr Modules.symvers
	@rm -fr Module.symvers
	@rm -fr Module.markers
	@rm -fr modules.order

sign:
ifeq ($(NO_SKIP_SIGN), y)
	@openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out MOK.der -nodes -days 36500 -subj "/CN=Custom MOK/"
	@mokutil --import MOK.der
else
	echo "Skipping key creation"
endif
ifeq ($(CONFIG_PCI), y)
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_pci.ko
endif
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_usb.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_sdio.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_core.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8723d.ko
ifeq ($(CONFIG_PCI), y)
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8723de.ko
endif
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8723du.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8723ds.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8822b.ko
ifeq ($(CONFIG_PCI), y)
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8822be.ko
endif
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8822bu.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8822bs.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8821c.ko
ifeq ($(CONFIG_PCI), y)
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8821ce.ko
endif
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8821cu.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8821cs.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8822c.ko
ifeq ($(CONFIG_PCI), y)
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8822ce.ko
endif
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8822cu.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8822cs.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8821a.ko
ifeq ($(CONFIG_PCI), y)
endif
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8821au.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8812au.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8703b.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8723x.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8723cs.ko

sign-install: all sign install

