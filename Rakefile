require 'yaml'

$AVAILABLES_VMS = YAML.load_file('config/basic/available_images.yml')

namespace :vms do |args|

  desc 'Start a virtual machine, all possibility available in config'
  task :start do
    wake_up_vms
    exit 0
  end

  desc 'Start vms, and configure it'
  task :deploy do
    wake_up_vms
    system('ansible-playbook -i hosts.local benchmark.yml')
    exit 0
  end

  desc 'Execute benchmark'
  task :runbenchmark do
    system('./scripts/stress_test.sh event localhost/~siqueira')
    exit 0
  end

  desc 'Halt all vms'
  task :haltall do
    vm_define = 'config/basic/vm_define.yml'
    # Before work
    if File.exists?(vm_define)
      row_file = YAML.load_file(vm_define)
      machines_names = row_file.keys
      hw_httpd = row_file[machines_names[0]][0]
      hw_request = row_file[machines_names[1]][0]
    else
      puts 'Cannot load file'
      exit 0
    end
    system("vagrant halt #{machines_names[1]}")
    system("vagrant halt #{machines_names[0]}")
  end

  desc 'Destroy all vms'
  task :destroyall do
    vm_define = 'config/basic/vm_define.yml'
    # Before work
    if File.exists?(vm_define)
      row_file = YAML.load_file(vm_define)
      machines_names = row_file.keys
      hw_httpd = row_file[machines_names[0]][0]
      hw_request = row_file[machines_names[1]][0]
    else
      puts 'Cannot load file'
      exit 0
    end
    system("vagrant destroy #{machines_names[1]}")
    system("vagrant destroy #{machines_names[0]}")
  end


  desc 'Login into the machine'
  task :login do
    vm_define = 'config/basic/vm_define.yml'
    if File.exists?(vm_define)
      row_file = YAML.load_file(vm_define)
      machines_names = row_file.keys
    else
      puts 'Cannot load file'
      exit 0
    end
    if ARGV.length <= 1
      puts 'We need to know witch machine do you want to entry'
      puts machines_names
      exit 0
    end

    system("ssh #{ENV['USER']}@localhost -p 2222")
    exit 0
  end

  def wake_up_vms
    if ARGV.length <= 1
      puts 'Wrong number or argument: provide the OS name'
      exit 0
    end

    vm_to_create = ARGV[1]

    if $AVAILABLES_VMS.has_key?(vm_to_create)
      target = $AVAILABLES_VMS[vm_to_create]
      system("VM=#{target} vagrant up --provider virtualbox")
    else
      puts 'Not available vm'
      exit 0
    end
  end

end

namespace :benchmark do
  desc 'Based on tsv files, generate graphs'
  task :generate_graphs do
    system('./scripts/generate_graphs.sh')
    exit 0
  end
end

desc 'Clean results'
task :clean do
  system('rm results/*')
  exit 0
end
