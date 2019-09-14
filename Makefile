MAJORVER := "1"
MINORVER := "5"
MICROVER := "0"
VERSION := $(MAJORVER).$(MINORVER).$(MICROVER)
COMMIT := $(shell git rev-parse --short HEAD)
all: checkpoint ftp goldleaf hkt hbloader hbmenu ams nxshell reinxspoofer kipselect sigpatches sin

clean:
	$(MAKE) -C Checkpoint clean
	$(MAKE) -C ftpd clean
	$(MAKE) -C hekate clean
	$(MAKE) -C Goldleaf/Goldleaf clean
	@$(MAKE) -C ReiNX-Spoofer/SimpleIniParser clean
	@$(MAKE) -C ReiNX-Spoofer/libstratosphere clean
	@$(MAKE) -C ReiNX-Spoofer clean
	# $(MAKE) -C nx-hbloader clean
	# $(MAKE) -C nx-hbmenu clean
	# $(MAKE) -C KipSelect clean
	$(MAKE) -f Vortex clean
	@rm -rf Vortex*.zip
	@rm -rf NX-Shell.nro
	@rm -rf Kip_Select.nro
	@rm -rf fusee-primary.bin
	@rm -rf ams.zip
	@rm -rf patches.zip
	@rm -rf Goldtree.exe

ams:
	# @$(MAKE) -C Atmosphere dist
	@echo "---------------------------------------------------------------"
	@echo "Downloading Atmosphere, because compiling may not be possible."
	@echo "Visit https://github.com/Atmosphere-NX/Atmosphere for help!"
	@echo "---------------------------------------------------------------"
	@[ -f ams.zip ] || wget "https://github.com/Atmosphere-NX/Atmosphere/releases/download/0.9.4/atmosphere-0.9.4-master-c62c4846+hbl-2.2+hbmenu-3.1.1.zip" -O ams.zip
	@[ -f fusee-primary.bin ] || wget "https://github.com/Atmosphere-NX/Atmosphere/releases/download/0.9.4/fusee-primary.bin" -O fusee-primary.bin

nxshell:
	@echo "---------------------------------------------------------------"
	@echo "Downloading NX-Shell, because compiling may not be possible."
	@echo "Visit https://github.com/joel16/NX-Shell for help!"
	@echo "---------------------------------------------------------------"
	@[ -f NX-Shell.nro ] || wget "https://github.com/joel16/NX-Shell/releases/download/2.00/NX-Shell.nro" -O NX-Shell.nro

kipselect:
	# @$(MAKE) -C KipSelect
	@echo "---------------------------------------------------------------"
	@echo "Downloading KipSelect, because compiling may not be possible."
	@echo "Visit https://github.com/Sciguy429/KipSelect for help!"
	@echo "---------------------------------------------------------------"
	@[ -f Kip_Select.nro ] || wget "https://github.com/Sciguy429/KipSelect/releases/download/3.0.9/Kip_Select_V3.0.9.nro" -O Kip_Select.nro

checkpoint:
	@$(MAKE) -C Checkpoint switch

ftp:
	@$(MAKE) -C ftpd/ nro

hkt:
	@$(MAKE) -C hekate

goldleaf:
	@$(MAKE) -C Goldleaf/Goldleaf
	@echo "---------------------------------------------------------------"
	@echo "Downloading Goldtree, because compiling may not be possible."
	@echo "Visit https://github.com/XorTroll/Goldleaf for help!"
	@echo "---------------------------------------------------------------"
	@[ -f Goldtree.exe ] || wget "https://github.com/XorTroll/Goldleaf/releases/download/0.6.1/Goldtree.exe" -O Goldtree.exe

hbloader:
	# @$(MAKE) -C nx-hbloader
	@echo "Included in Atmosphere"

hbmenu:
	# @$(MAKE) -C nx-hbmenu nx
	@echo "Included in Atmosphere"

reinxspoofer:
	@$(MAKE) -C ReiNX-Spoofer/SimpleIniParser
	@$(MAKE) -C ReiNX-Spoofer/libstratosphere
	@$(MAKE) -C ReiNX-Spoofer

sigpatches:
	@echo "----------------------------------------------------------------------------------------------------------------"
	@echo "Downloading IPS patches (ES & FS), because compiling may not be possible."
	@echo "Visit https://gbatemp.net/threads/i-heard-that-you-guys-need-some-sweet-patches-for-atmosphere.521164/ for help!"
	@echo "----------------------------------------------------------------------------------------------------------------"
	@[ -f patches.zip ] || curl "https://cdn.discordapp.com/attachments/444174715314241537/621296614199263233/2.0.0-9.0.0.zip" -o patches.zip

sin:
	$(MAKE) -f Vortex

release: all
	cd _dist; zip Vortex.zip * -r -9; mv Vortex.zip ../Vortex-$(VERSION)-$(COMMIT).zip
