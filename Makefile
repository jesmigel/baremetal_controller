.PHONY: up down clean

# LOCAL TESTING
#	Vagrant: Virtual Machine Manager
#	Packer: ISO Builder
up:
	vagrant up

down:
	vagrant down

clean:
	vagrant destroy -f


sm_init:
	git submodule update --init --recursive

_ESXI_ISO=$(HOME)/VMware-VMvisor-Installer-6.7.0.update03-14320388.x86_64.iso
_ESXI_PATH=$(PWD)/submodules/packer-maas/vmware-esxi
_ESXI_JSON=vmware.esxi.json
packer_build:
	cp -f ./config/vmware.esxi.json $(_ESXI_PATH)/$(_ESXI_JSON)
	$(call f_packer,$(_ESXI_ISO),$(_ESXI_JSON))
# $1:	ISO absolute path
# $2:	Packer input json
define f_packer
	sudo bash -c ' \
	cd $(_ESXI_PATH) && \
	PACKER_LOG=1 \
	packer build -var "vmware_esxi_iso_path=$(1)" $(2) '
endef
