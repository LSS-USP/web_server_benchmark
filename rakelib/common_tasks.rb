module Common

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

  # Read from configuration
  # @param What you want from current environment
  def get_configuration_from(specific='all')
    vm_define = 'config/vms/basic/machine_define.yml'
    # Before work
    if File.exists?(vm_define)
      row_file = YAML.load_file(vm_define)
      machines_names = row_file.keys
      hw_httpd = row_file[machines_names[0]][0]
      hw_request = row_file[machines_names[1]][0]
      case specific
      when 'names'
        return machines_names
      when 'hardware'
        return hw_request, hw_httpd
      else
        return hw_httpd, hw_request, machines_names
      end
    else
      puts 'Cannot load file'
      exit 0
    end
  end

end
