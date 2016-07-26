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

  # Define to run apache settings
  config.vm.define 'apache_httpd' do |httpd|
    httpd.vm.box = ENV['VM']
	  httpd.vm.network 'forwarded_port', guest: 80, host: 8080

    httpd.vm.provider 'virtualbox' do |vm, override|
      vm.memory = hw_config['memory']
      vm.cpus = hw_config['cpus']
    end

    ssh_path = "#{ENV['HOME']}/.ssh/id_rsa.pub"
    id_pub = File.read(ssh_path)
    httpd.vm.provision 'shell', keep_color: true, path: 'vagrant/bootstrap.sh'
    httpd.vm.provision 'shell', privileged: true, keep_color: true, args: "#{ENV['USER']} #{id_pub}", path: 'vagrant/provision.sh'
  end

  # Define vm to start requests
  config.vm.define 'benchmark_arch' do |requests|
    requests.vm.box = 'minimal/trusty64'

    requests.vm.provider 'virtualbox' do |vm, override|
      vm.memory = 1024
      vm.cpus = 2
    end
    requests.vm.network 'public_network', ip: "10.0.0.201"
	  requests.vm.network 'forwarded_port', guest: 80, host: 1234
    #ssh_path = "#{ENV['HOME']}/.ssh/id_rsa.pub"
    #id_pub = File.read(ssh_path)
    #requests.vm.provision 'shell', keep_color: true, path: 'vagrant/bootstrap.sh'
    #requests.vm.provision 'shell', privileged: true, keep_color: true, args: "#{ENV['USER']} #{id_pub}", path: 'vagrant/provision.sh'
  end

end
