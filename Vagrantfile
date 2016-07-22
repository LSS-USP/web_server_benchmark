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

  # Define vm configurations
  config.vm.define 'apache_httpd' do |httpd|
    httpd.vm.provider 'virtualbox' do |vm, override|
      override.vm.network 'private_network', ip: '10.10.10.2'
      vm.memory = hw_config['memory']
      vm.cpus = hw_config['cpus']
    end
  end

end
