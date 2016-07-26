# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

Vagrant.configure('2') do |config|
  vm_define = 'config/basic/vm_define.yml'
  # Before work
  if File.exists?(vm_define)
    row_file = YAML.load_file(vm_define)
    machines_names = row_file.keys
    hw_httpd = row_file[machines_names[0]][0]
    hw_request = row_file[machines_names[1]][0]
  else
    machines_names = ['apache_httpd', 'benchmark_requests']
    hw_httpd = {memory: 1024, cpus: 2}
    hw_request = {memory: 1024, cpus: 2}
  end

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.

  # Define to run apache settings
  config.vm.define machines_names[0] do |httpd|
    httpd.vm.box = ENV['VM'] || 'bugyt/archlinux'
	  httpd.vm.network 'forwarded_port', guest: 80, host: 8080

    httpd.vm.provider 'virtualbox' do |vm, override|
      vm.memory = hw_httpd['memory']
      vm.cpus = hw_httpd['cpus']
    end

    ssh_path = "#{ENV['HOME']}/.ssh/id_rsa.pub"
    httpd.vm.provision 'shell', privileged: true, keep_color: true, args: "#{ENV['USER']}", path: 'vagrant/bootstrap.sh'
  end

  # Define vm to start requests
  config.vm.define machines_names[1] do |requests|
    requests.vm.box = 'minimal/trusty64'

    requests.vm.provider 'virtualbox' do |vm, override|
      vm.memory = hw_request['memory']
      vm.cpus = hw_request['cpus']
    end
    requests.vm.network 'public_network', ip: "10.0.0.201"
    requests.vm.network 'forwarded_port', guest: 80, host: 1234
    requests.vm.provision 'shell', privileged: true, keep_color: true, args: "#{ENV['USER']}", path: 'vagrant/bootstrap.sh'
  end

end
