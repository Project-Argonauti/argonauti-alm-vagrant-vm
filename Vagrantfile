# -*- mode: ruby -*-
# vi: set ft=ruby :

SSL_STATUS = true
box_name = "ubuntu/jammy64"
hostname = "argonauti.alm"

Vagrant.configure("2") do |config|
  config.vm.define "#{hostname}" do |box|
    box.vm.boot_timeout = 1800
    box.vm.box = "#{box_name}"
    box.vm.box_download_options = {"ssl-no-revoke" => SSL_STATUS}
    box.vm.hostname = "#{hostname}"

    box.vm.network "private_network", ip: "192.168.23.42"

    box.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.cpus = "2"
    end
  end
end
