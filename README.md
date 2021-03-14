# jc_controller
Repository for bootstrapping a cluster controller.

## Requirements: Software
- [Ubuntu 20.04 LTS](https://releases.ubuntu.com/)
- [Canonical MaaS](https://maas.io/docs/snap/2.9/ui/installation)
- [Packer](https://learn.hashicorp.com/tutorials/packer/getting-started-install)
- [VMWare ESXI](https://www.vmware.com/au/products/esxi-and-esx.html)

## Sample Requirements: Hardware
- Dell Poweredge r710 (3x)
- Dell Poweredge r810 (2x)

## Installation: OS
- Create a bootable flashdrive of Install Ubuntu 20.04 LTS through [balenaEtcher](https://www.balena.io/etcher/)
- Install Ubuntu 20.04 LTS to a r710

## Bootstrap: Controller
- Login to the controller host and execute the succeeding shell commands
```bash
# Clone github repo
git clone https://github.com/jesmigel/jc_controller.git

# Change directory to repo
cd jc_controller

# Execute bootstrap script
./scripts/bootsrap.maas.sh $ADMIN_ID $HOST_IP $ADMIN_PASSWORD $ADMIN_EMAIL $GITHUB_USER 
```
---
## [Packer MaaS](https://github.com/canonical/packer-maas)
Used to create custom ISO's thats used by MaaS to PXE bootstrap baremetal servers

### Installation
```bash
# Change directory to repo
cd jc_controller

# Execute bootstrap script
./scripts/bootsrap.packer.sh
```

### Update [Packer MaaS](https://github.com/canonical/packer-maas) submodule recursively
```bash
# Change directory to repo
cd jc_controller

# Execute make command
make sm_update # git submodule update --init --recursive
```

### Procure VMWare ESXI ISO's
*NOTE:* You'll need to register to VMWare in order to get the free license of the following ESXI ISO's
- [VMWare ESXI 6.XX](https://my.vmware.com/en/group/vmware/evalcenter?p=free-esxi6)
- [VMWare ESXI 7.XX](https://my.vmware.com/en/group/vmware/evalcenter?p=free-esxi7)

### Build ESXI ISO and deploy to MaaS
```bash
#### Confirm files relative paths
# VMware ESXI ISO's: ${HOME}/*.iso
# Repo location: ${HOME}/jc_controller
# Packer MaaS git submodule: ${HOME}/jc_controller/submodules/packer-maas

# Preseed configuration file
#   Review the listed file(s) and configure as desired.
#   - jc_controller/config/vmware.esxi.json

# Execute build script
make packer_build

# Authenticate to MaaS
make maas_auth _MAAS_USER='ENTER_USER_ID' _MAAS_API='ENTER_MAAS_API'

# Push image to MaaS
make maas_push _MAAS_IMG_NAME='_ENTER_IMAGE_NAME' _MAAS_IMG_TITLE='_ENTER_IMAGE_TITLE' _MAAS_IMG_FILE='_ENTER_IMAGE_FILE'
```
