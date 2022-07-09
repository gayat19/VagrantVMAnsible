# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure(2) do |config|

  config.vm.provision "shell", path: "bootstrap.sh"

  # To Setup the Ansible Lab environment
  # acs Node
  config.vm.define "acs" do |acs|
    acs.vm.box = "centos/7"
    acs.vm.hostname = "acs.example.com"
    acs.vm.network "private_network", ip: "172.16.1.100"
    acs.vm.provider "virtualbox" do |v|
      v.name = "acs"
      v.memory = 2048
      v.cpus = 2
    end
    acs.vm.provision "shell", path: "bootstrap_acs.sh"
  end

  NodeCount = 2

  # Nodes To Manage
  (1..NodeCount).each do |i|
    config.vm.define "node#{i}" do |node|
      node.vm.box = "centos/7"
      node.vm.hostname = "node#{i}.example.com"
      node.vm.network "private_network", ip: "172.16.1.10#{i}"
      node.vm.provider "virtualbox" do |v|
        v.name = "node#{i}"
        v.memory = 1024
        v.cpus = 1
      end
      node.vm.provision "shell", path: "bootstrap_node.sh"
    end
  end

end
