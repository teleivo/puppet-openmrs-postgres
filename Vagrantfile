# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  # Ports
  # tomcat port (openmrs)
  config.vm.network "forwarded_port", guest: 8080, host: 8080

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false
  
    # Customize the amount of memory on the VM:
    vb.memory = "2000"
  end

  # Install librarian-puppet and necessary puppet modules
  config.vm.provision "shell" do |shell|
    shell.path = "bootstrap.sh"
  end

  # Install/Configure dcm4chee/openmrs via puppet
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "site.pp"
    puppet.hiera_config_path = "hiera.yaml"
    puppet.module_path = 'modules'
  end
end
