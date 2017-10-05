# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

    config.vm.box = "bento/ubuntu-16.04"
    config.vm.box_check_update = true
    config.vm.hostname = "lemp7-vm"

    config.vm.network :forwarded_port, guest: 80, host: 8082
    config.vm.network :forwarded_port, guest: 3306, host: 3308
    config.vm.network :forwarded_port, guest: 6379, host: 6381
    config.vm.network :forwarded_port, guest: 27017, host: 27017

    config.vm.network "private_network", ip: "192.168.3.42"

    config.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--memory", "2048"]
        v.customize ["modifyvm", :id, "--vram", "32"]
    end
    
    # set project folder here:
    config.vm.synced_folder "www/", "/var/www", 
        owner: "www-data", 
        group: "www-data",
        mount_options: ["dmode=775,fmode=664"]

    config.vm.provision "shell", path: "./scripts/setup.sh"
end
