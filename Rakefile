require 'yaml'

$AVAILABLES_VMS = YAML.load_file('config/basic/available_images.yml')

namespace :vms do |args|

  desc 'Start a virtual machine, all possibility available in config'
  task :start do
    if ARGV.length <= 1
      puts 'Wrong number or argument: provide the os name'
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

  desc 'Start vms, and configure it'
  task :deploy => 'vms:start'  do
    system('ansible-playbook -i hosts benchmark.yml')
    exit 0
  end

  desc 'Execute benchmark'
  task :runbenchmark do
    system('./scripts/stress_test.sh event localhost/~siqueira')
    exit 0
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
