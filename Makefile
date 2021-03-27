.PHONY: up down clean printenv

# LOCAL TESTING
#	Vagrant: Virtual Machine Manager
#	Packer: ISO Builder

# IMPORT ENV FILES
_ENV_DIR=./env
include $(_ENV_DIR)/sample.maas.env
include $(_ENV_DIR)/sample.esxi.67.env

printenv:
	@echo "MAAS ENV VARS:"
	@echo "_MAAS_USER: $(_MAAS_USER)"
	@echo "_MAAS_API: $(_MAAS_API)"
	@echo ""
	@echo "PACKER ENV VARS"
	@echo "_ESXI_ISO: $(_ESXI_ISO)"
	@echo "_ESXI_PATH: $(_ESXI_PATH)"
	@echo "_ESXI_JSON: $(_ESXI_JSON)"
	@echo "_MAAS_IMG_NAME: $(_MAAS_IMG_NAME)"
	@echo "_MAAS_IMG_TITLE: $(_MAAS_IMG_TITLE)"
	@echo "_MAAS_IMG_FILE: $(_MAAS_IMG_FILE)"

up:
	vagrant up

down:
	vagrant down

clean:
	vagrant destroy -f

.PHONY: sm_init sm_update sm_sync
sm_init:
	$(call f_git_sub,update --init --recursive)
sm_update:
	$(call f_git_sub,update --recursive)
sm_sync:
	$(call f_git_sub,sync --recursive)


.PHONY: packer_build

packer_build:
	cp -f ./config/vmware.esxi.json $(_ESXI_PATH)/$(_ESXI_JSON)
	$(call f_packer_build,$(_ESXI_ISO),$(_ESXI_JSON))
	mv $(_ESXI_PATH)/vmware-esxi.dd.gz .

.PHONY: maas_auth
maas_auth:
	@echo "_MAAS_USER env var must be set"
	maas login $(_MAAS_USER) $(_MAAS_API)

maas_push: 
	$(call f_maas,$(_MAAS_IMG_NAME),$(_MAAS_IMG_TITLE),$(_MAAS_IMG_FILE))

# MAAS push image
define f_maas
	maas admin boot-resources create name='$1' \
	title='$2' \
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