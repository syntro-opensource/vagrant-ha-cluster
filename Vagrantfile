# -*- mode: ruby -*-
# vi: set ft=ruby :

gluster1_brick = './bricks/gluster1_brick.vdi'
gluster2_brick = './bricks/gluster2_brick.vdi'


Vagrant.configure("2") do |config|


  # ------------------------------------------------------
  #                 Ansible Bastion
  # ------------------------------------------------------

  config.vm.define "ansible_bastion", autostart: false do |ansible_bastion|
    ansible_bastion.vm.box = "bento/ubuntu-16.04"
    ansible_bastion.vm.network "private_network", ip: "192.168.200.2"
    ansible_bastion.vm.hostname = "bastion.syntro.local"
    ansible_bastion.vm.synced_folder "./ansible", "/home/vagrant/ansible", type: "nfs", create: true
    ansible_bastion.ssh.forward_agent = true
    ansible_bastion.vm.provision "file", source: "files/key/id_rsa", destination: "~/.ssh/id_rsa"
    ansible_bastion.vm.provision "shell" do |s|
      s.path = "scripts/provision_bastion.sh"
    end
    ansible_bastion.vm.provider "virtualbox" do |vb|
      vb.name = "syntro-ansible-bastion"
      vb.memory = "512"
      vb.cpus = 1
    end
  end

  # ------------------------------------------------------
  #                 Rancher Master
  # ------------------------------------------------------

  config.vm.define "rancher_master" do |rancher_master|
    rancher_master.vm.box = "bento/ubuntu-16.04"
    rancher_master.vm.network "private_network", ip: "192.168.200.10"
    rancher_master.vm.hostname = "master.rancher.local"
    rancher_master.ssh.forward_agent = true
    rancher_master.vm.provision "file", source: "files/key/id_rsa.pub", destination: "~/.ssh/id_rsa.pub"
    rancher_master.vm.provision "shell" do |s|
      s.path = "scripts/provision.sh"
    end
    rancher_master.vm.provider "virtualbox" do |vb|
      vb.name = "syntro-rancher-master"
      vb.memory = "1024"
      vb.cpus = 1
    end
  end

  # ------------------------------------------------------
  #                 Rancher Slave
  # ------------------------------------------------------

  config.vm.define "rancher_slave1" do |rancher_slave1|
    rancher_slave1.vm.box = "bento/ubuntu-16.04"
    rancher_slave1.vm.network "private_network", ip: "192.168.200.11"
    rancher_slave1.vm.hostname = "slave1.rancher.local"
    rancher_slave1.hostsupdater.aliases = ["test1.rancher.local", "test2.rancher.local"]
    rancher_slave1.ssh.forward_agent = true
    rancher_slave1.vm.provision "file", source: "files/key/id_rsa.pub", destination: "~/.ssh/id_rsa.pub"
    rancher_slave1.vm.provision "shell" do |s|
      s.path = "scripts/provision.sh"
    end
    rancher_slave1.vm.provider "virtualbox" do |vb|
      vb.name = "syntro-rancher-slave1"
      vb.memory = "2048"
      vb.cpus = 2
    end
  end

  # ------------------------------------------------------
  #                 Gluster Server 1
  # ------------------------------------------------------

  config.vm.define "gluster1" do |gluster1|
    gluster1.vm.box = "bento/ubuntu-16.04"
    gluster1.vm.network "private_network", ip: "192.168.200.21"
    gluster1.vm.hostname = "gluster1.storage.local"
    gluster1.ssh.forward_agent = true
    gluster1.vm.provision "file", source: "files/key/id_rsa.pub", destination: "~/.ssh/id_rsa.pub"
    gluster1.vm.provision "shell" do |s|
      s.path = "scripts/provision.sh"
    end
    gluster1.vm.provider "virtualbox" do |vb|
      unless File.exist?(gluster1_brick)
        vb.customize ['createhd', '--filename', gluster1_brick, '--variant', 'Fixed', '--size', 5 * 1024]
      end
      vb.customize ['storageattach', :id,  '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', gluster1_brick]
      vb.name = "syntro-gluster1"
      vb.memory = "1024"
      vb.cpus = 1
    end
  end

  # ------------------------------------------------------
  #                 Gluster Server 2
  # ------------------------------------------------------

  config.vm.define "gluster2" do |gluster2|
    gluster2.vm.box = "bento/ubuntu-16.04"
    gluster2.vm.network "private_network", ip: "192.168.200.22"
    gluster2.vm.hostname = "gluster2.storage.local"
    gluster2.ssh.forward_agent = true
    gluster2.vm.provision "file", source: "files/key/id_rsa.pub", destination: "~/.ssh/id_rsa.pub"
    gluster2.vm.provision "shell" do |s|
      s.path = "scripts/provision.sh"
    end
    gluster2.vm.provider "virtualbox" do |vb|
      unless File.exist?(gluster2_brick)
        vb.customize ['createhd', '--filename', gluster2_brick, '--variant', 'Fixed', '--size', 5 * 1024]
      end
      vb.customize ['storageattach', :id,  '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', gluster2_brick]
      vb.name = "syntro-gluster2"
      vb.memory = "1024"
      vb.cpus = 1
    end
  end

end
