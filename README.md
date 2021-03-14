# jc_controller
Repository for bootstrapping a cluster controller.

## Requirements: Software
- [Ubuntu 20.04 LTS](https://releases.ubuntu.com/)
- [Canonical MaaS](https://maas.io/docs/snap/2.9/ui/installation)
- [Packer](https://learn.hashicorp.com/tutorials/packer/getting-started-install)
- [VMWare ESXI 6.7 update 3](https://my.vmware.com/en/group/vmware/evalcenter?p=free-esxi6)

## Sample Requirements: Hardware
- Dell Poweredge r710 (3x)
- Dell Poweredge r810 (2x)

## Installation: OS
- Create a bootable flashdrive of Install Ubuntu 20.04 LTS through [balenaEtcher](https://www.balena.io/etcher/)
- Install Ubuntu 20.04 LTS to a r710

## Bootstrap: Controller
- Login to the controller host and execute the succeeding shell commands
```bash
# Initialise bootstrap directory
git clone https://github.com/jesmigel/jc_controller.git
cd jc_controller

# Execute bootstrap script
./scripts/bootsrap.maas.sh $ADMIN_ID $HOST_IP $ADMIN_PASSWORD $ADMIN_EMAIL $GITHUB_USER 
```