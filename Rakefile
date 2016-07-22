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
      exit 0
    else
      puts 'Not available vm'
      exit 0
    end
  end
end

namespace :benckmark do

end
