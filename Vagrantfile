# -*- mode: ruby -*-
# vi: set ft=ruby :
cookbook_name   = "lang_pack"
box             = "ge_windows2008r2"
box_url         = "http://acusvinolare001.frictionless.capital.ge.com/virtualbox/ge_windows2008r2.box"
hostname        = "windows2008r2"

Vagrant.configure("2") do |config|
  config.vm.define cookbook_name do |config|
    config.vm.box               = box
    config.vm.box_url           = box_url
    config.vm.hostname          = hostname
    config.vm.guest             = :windows
    config.windows.halt_timeout = 25
    config.winrm.username       = "vagrant"
    config.winrm.password       = "vagrant"
    config.winrm.host           = "localhost"
    config.berkshelf.enabled    = true
    config.vm.network :forwarded_port, { :guest=>3389, :host=>3389, :id=>"rdp", :auto_correct=>true }
    config.vm.network :forwarded_port, { :guest=>5985, :host=>5985, :id=>"winrm", :auto_correct=>true }

    config.vm.provider :virtualbox do |p|
        p.customize ["modifyvm", :id, "--memory", "1024"]
    end

    config.vm.provision :chef_solo do |chef|
      chef.log_level = :auto
      chef.run_list = ["recipe[" + cookbook_name + "]"]
    end
  end
end
