# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.hostname = "docker01"

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "chef/fedora-21"
  config.vm.hostname = 'webdrupal.dev'
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 2
  end
  config.vm.synced_folder 'webdrupal/', '/usr/share/webdrupal'
  config.vm.synced_folder 'webux/', '/usr/share/webux'
  config.vm.synced_folder 'containers/', '/usr/local/containers'
  config.vm.provision "shell", path: './bootstrap.sh'
end
