# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  ## Configuring berkshelf
  config.vm.box = "alex_win2k8"

  # Create a private network, which allows host-only access to the machine
  config.vm.network :public_network, ip: "111.222.33.4", :bridge => 'en0: Wi-Fi (AirPort)'
  # Create a forwarded port mapping which allows access to a specific port
  config.vm.network "forwarded_port", guest: 5985, host: 15985  # winrm
  config.vm.network "forwarded_port", guest: 3389, host: 13390  # remote desktop
  # config.vm.network "forwarded_port", guest: 4000, host: 4000   # chef-zero


# config.omnibus.chef_version = :latest

  # Share an additional folder to the guest VM. The first argument is
  config.vm.synced_folder "../", "c:/cookbooks_path"
  config.vm.synced_folder "binaries/", "c:/binaries"


  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  config.vm.guest = :windows
  config.windows.halt_timeout = 25
  config.winrm.username = "vagrant"
  config.winrm.password = "vagrant"
  config.winrm.max_tries = 30


  # Example for VirtualBox:
  config.vm.provider :virtualbox do |vb|
    vb.gui = true
    vb.name = "alex_packer2k8r2"
  
    vb.customize [
      "modifyvm", :id,
       "--memory", "1536"
     ]
  end


  # Enable provisioning with chef solo
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "."
    chef.add_recipe "win_lang_pack"
    chef.log_level = :debug
  end

end



