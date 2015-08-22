# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "flags.minefield.dev", primary: true
  config.vm.boot_timeout = 1000

  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", ip: "10.0.10.3"
  config.vm.synced_folder ".", "/opt/minefield-flags", type: "nfs"
  config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
  end

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "ansible/all.yml"

    ansible.groups = {
      "loadbalancer" => ["flags.minefield.dev"],
      "database" => ["flags.minefield.dev"],
      "app" => ["flags.minefield.dev"],
      "vagrant:children" => ["loadbalancer", "database", "app"]
    }
  end
end
