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

end
