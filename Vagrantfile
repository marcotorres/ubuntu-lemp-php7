# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    config.vm.box = "bento/ubuntu-19.10"
    config.vm.box_version = "202003.31.0"
    config.vm.box_check_update = false
    config.vm.box_download_insecure = true
    config.vbguest.auto_update = false
    config.vm.hostname = "lemp7"
    config.vm.post_up_message = "¡Hecho! Ahora puedes acceder al sitio en http://lemp7.vh"

    config.vm.network :forwarded_port, guest: 80, host: 8080
    config.vm.network :forwarded_port, guest: 3306, host: 3306
    config.vm.network :forwarded_port, guest: 6379, host: 6379
    config.vm.network :forwarded_port, guest: 27017, host: 27017
    config.vm.network "private_network", ip: "192.168.2.3"

    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
    config.vm.define 'lemp7' do |node|
        node.hostmanager.aliases = %w(
        lemp7
        lemp7.vh
        )
    end

    config.vm.provider :virtualbox do |v|
	v.name = "lemp7"
        v.customize ["modifyvm", :id, "--memory", "2048"]
        v.customize ["modifyvm", :id, "--vram", "32"]
	    v.customize ["modifyvm", :id, "--cpus", "2"]
    end

    config.vm.synced_folder "www/", "/var/www", 
        owner: "www-data", 
        group: "www-data",
        mount_options: ["dmode=775,fmode=664"]

    config.vm.provision "shell", path: "./console/provision.sh"
end
