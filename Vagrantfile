# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
VM_WEB_IP = "127.0.0.1"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "bento/centos-6.7"

  config.vm.boot_timeout = 300

  config.vm.synced_folder ".", "/vagrant",
    disabled: true

  config.ssh.forward_agent = true

  config.vm.provision "file",
    source: "server-config",
    destination: "/tmp/server-config"

  config.vm.provider "virtualbox" do |v|
      v.memory = 1024
  end

  # Base provisioning, things like installing servers and runtimes.
  config.vm.provision "shell",
    path: "base_provision.sh"

  config.vm.network "forwarded_port", host_ip: VM_WEB_IP, guest: 80, host: 80
  config.vm.network "forwarded_port", host_ip: VM_WEB_IP, guest: 443, host: 443

  # Port to make direct connection to MySQL
  # See more info in http://stackoverflow.com/questions/14779104/how-to-allow-remote-connection-to-mysql
  # config.vm.network "forwarded_port", host_ip: VM_WEB_IP, guest: 3306, host: 9309
end
