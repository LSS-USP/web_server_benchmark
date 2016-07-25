# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

Vagrant.configure('2') do |config|
  vm_define = 'config/basic/vm_define.yml'
  # Before work
  if File.exists?(vm_define)
    hw_config = YAML.load_file(vm_define)
  else
    hw_config = {memory: 1024, cpus: 2}
  end

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = ENV['VM']
	config.vm.network 'forwarded_port', guest: 80, host: 8080

  # Define vm configurations
  config.vm.define 'apache_httpd' do |httpd|
    httpd.vm.provider 'virtualbox' do |vm, override|
      vm.memory = hw_config['memory']
      vm.cpus = hw_config['cpus']
    end
  end

  ssh_path = "#{ENV['HOME']}/.ssh/id_rsa.pub"
  id_pub = File.read(ssh_path)
  config.vm.provision 'shell', keep_color: true, path: 'vagrant/bootstrap.sh'
  config.vm.provision 'shell', privileged: true, keep_color: true, args: "#{ENV['USER']} #{id_pub}", path: 'vagrant/provision.sh'

end
