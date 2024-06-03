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
      vb.memory = "8192"
      vb.cpus = "4"
    end

    box.vm.provision "ansible_local" do |ansible|
      #ansible.compatibility_mode = "auto"
      ansible.become = true
      ansible.verbose = "v"
      ansible.playbook = "./playbook.yml"
      #ansible.raw_arguments  = "--ask-vault-pass"
      ansible.extra_vars = {
         ansible_python_interpreter: "/usr/bin/python3"
         #ansible_roles_path: "/vagrant/ansible-roles"
      }
   end
  end
end
