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

.PHONY: sm_init sm_update sm_sync
sm_init:
	$(call f_packer_build,"update --init --recursive")
sm_update:
	$(call f_packer_build,"update --recursive")
sm_sync:
	$(call f_packer_build,"sync --recursive")


.PHONY: packer_build
_ESXI_ISO=$(HOME)/VMware-VMvisor-Installer-6.7.0.update03-14320388.x86_64.iso
_ESXI_PATH=$(PWD)/submodules/packer-maas/vmware-esxi
_ESXI_JSON=vmware.esxi.json
packer_build:
	cp -f ./config/vmware.esxi.json $(_ESXI_PATH)/$(_ESXI_JSON)
	$(call f_packer_build,$(_ESXI_ISO),$(_ESXI_JSON))

.PHONY: maas_auth
_MAAS_API=http://192.168.122.1:5240/MAAS/
maas_auth:
	@echo "_MAAS_USER env var must be set"
	maas login $(_MAAS_USER) $(_MAAS_API)

_MAAS_IMG_NAME=""
_MAAS_IMG_TITLE=""
_MAAS_IMG_FILE=""
maas_push: 
	$(call f_maas,)

# MAAS push image
define f_maas
	maas admin boot-resources create name='$1' \
	title='$2'
	architecture='amd64/generic' filetype='ddgz' \
	content@=$3
endef

# PACKER BUILD
# $1:	ISO absolute path
# $2:	Packer input json
define f_packer_build
	sudo bash -c ' \
	cd $(_ESXI_PATH) && \
	PACKER_LOG=1 \
	packer build -var "vmware_esxi_iso_path=$(1)" $(2) '
endef

# GIT SUBMODULE
define f_git_sub
	git submodule $(1)
endef