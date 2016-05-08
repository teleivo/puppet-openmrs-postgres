# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "emr.openmrs.org"

  # Ports
  # postgresql port
  config.vm.network "forwarded_port", guest: 5432, host: 5432

  # tomcat port (openmrs)
  config.vm.network "forwarded_port", guest: 8080, host: 8080

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "3000"
  end

  # Install git, r10k
  config.vm.provision "shell" do |shell|
    shell.path = "bootstrap.sh"
  end
  # Deploy and apply puppet environment
  # pass git branch name of environment you want to deploy via args
  git_branch_name = `git rev-parse --abbrev-ref HEAD`
  config.vm.provision "shell" do |shell|
    shell.path = "puppet_deploy_apply.sh"
    shell.args = git_branch_name
  end
end
