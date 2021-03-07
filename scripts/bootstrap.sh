#!/bin/bash
# Update Host
apt-get update -y

# Install docker and docker-compose
apt-get install -y docker.io docker-compose
usermod -aG docker ubuntu

# Install nfs client
apt-get install nfs-client
