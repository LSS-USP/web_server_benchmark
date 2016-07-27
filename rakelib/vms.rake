require 'yaml'
require_relative 'common_tasks'

$AVAILABLES_VMS = YAML.load_file('config/vms/basic/available_images.yml')

namespace :vms do |args|

  include Common

  desc 'Start a virtual machine, all possibility available in config'
  task :start do
    wake_up_vms
    exit 0
  end

  desc 'Halt all vms'
  task :haltall do
    vm_define = "config/#{$BENCH_ENV}/basic/machine_define.yml"
    machines_names = get_configuration_from('names')
    machines_names.each do |name|
      system("vagrant halt #{name}")
    end
  end

  desc 'Destroy all vms'
  task :destroyall do
    vm_define = "config/#{$BENCH_ENV}/basic/machine_define.yml"
    machines_names = get_configuration_from('names')
    machines_names.each do |name|
      system("vagrant destroy #{name}")
    end
  end

  desc 'Login into the machine'
  task :login do
    vm_define = 'config/vms/basic/machine_define.yml'
    if File.exists?(vm_define)
      row_file = YAML.load_file(vm_define)
      machines_names = row_file.keys
      hw_httpd = row_file[machines_names[0]][0]
      hw_request = row_file[machines_names[1]][0]
    else
      puts 'Cannot load file'
      exit 0
    end
    if ARGV.length <= 1
      puts 'We need to know witch machine do you want to entry'
      puts machines_names
      exit 0
    end
    port = row_file[ARGV[1]][0]['port']
    system("ssh #{ENV['USER']}@localhost -p #{port}")
    exit 0
  end

end
