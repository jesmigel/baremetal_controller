#!/bin/bash
# CONFIRM env vars
if [ $# -ne 4 ]; then
    echo "Missing arguments detected"
    echo "\$1: MaaS admin ID"
    echo "\$2: MaaS host IP"
    echo "\$3: MaaS admin password"
    echo "\$4: Github ID. Used by MaaS to procure pub key for provisioned hosts"
    exit -1
fi

user_id=$1
host_ip=$2
user_pass=$3
user_email=$4
gh_id=$5

# Update apt repo
sudo apt update -y

# Upgrade snap
sudo apt upgrade -y snap

# MaaS installation
# We’ll quickly walk through these instructions to confirm your understanding. First, install the maas-test-db snap:
sudo snap install maas-test-db

# Snaps are containerised software packages. To install MAAS from a snap simply enter the following:
sudo snap install --channel=2.9/stable maas

# Bootstrap MAAS
sudo maas init region+rack --database-uri maas-test-db:/// --maas-url http://$host_ip:5240/MAAS

# To create admins when not using external authentication, run
sudo maas createadmin --username $user_id --password $user_pass --email $user_email --ssh-import gh:$gh_id

# MANUAL
# - Import Images
# - Enable DHCP on vlan

# Get API key
sudo maas apikey --username $user_id
