# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    # Use the precised64 box, change this for 32 bit, or other distro
    config.vm.box = "hashicorp/precise64"

    # Run the provisioning script
    config.vm.provision :shell, :path => "./provision/bootstrap.sh"

    # Port forward HTTP (8080) to host 2020
    config.vm.network :forwarded_port, host: 2020, guest: 8080

    # Set the box host-name
    config.vm.hostname = "scape-demos"

    # VirtualBox specific, set the virtual box name
    config.vm.provider "virtualbox" do |v|
        v.name = "scape-demos-dev"
    end

    if Vagrant.has_plugin?("vagrant-proxyconf")
    	config.proxy.http     = "http://my.proxy:8080/"
    	config.proxy.https    = "http://my.proxy:8080/"
    	config.proxy.no_proxy = "localhost,127.0.0.1"
    end
end
