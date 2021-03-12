# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  # config.vm.box_check_update = false

  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  config.vm.network "private_network", ip: "10.10.10.10"
  # config.vm.network "public_network"
  
  config.vm.synced_folder "./scripts", "/mnt/scripts"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #

  config.vm.disk :disk, size: "32GB", primary: true
  
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    # vb.gui = true
    # Customize the amount of memory on the VM:
    vb.memory = "4096"
    vb.cpus = "8"
    vb.customize ['modifyvm', :id, '--paravirtprovider', 'kvm']
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
  echo "TEST BOOTSTRAP SCRIPTS"
  chmod -R +x /mnt/scripts/
  echo "TEST1: MAAS"
  /mnt/scripts/bootstrap.maas.sh test_user test_password test_email@test.com jesmigel
  echo "TEST2: PACKER"
  /mnt/scripts/bootstrap.packer.sh
  SHELL
end
