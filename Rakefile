require 'yaml'
require 'rake'

$BENCH_ENV = ENV.fetch('DEPLOY_TO', 'vms')

namespace :benchmark do
  desc 'Start bench'
  task :run do
    if ARGV.length <= 1
      puts 'Wrong number of arguments, you should provide the environment'
      exit 0
    end
    vm_define = "config/#{ARGV[1]}/basic/machine_define.yml"
    if File.exists?(vm_define)
      row_file = YAML.load_file(vm_define)
      machines_names = row_file.keys
      hw_request = row_file[machines_names[1]][0]
    else
      puts 'Cannot load file'
      exit 0
    end
    port = hw_request['port']
    host = hw_request['host']
    command = "ssh #{ENV['USER']}@#{host} -p #{port} "
    command += "'bash -s' < scripts/stress_test.sh event http://192.168.33.49:8080/"
    system(command)

    last_collected = Time.now.strftime("%d-%m-%Y_%H-%M")
    last_collected = "results/#{last_collected}_data"
    system("mkdir #{last_collected}")

    command = "scp -rp -P #{port} #{ENV['USER']}@#{host}:"
    command += "/home/siqueira/results/* #{last_collected}"

    system(command)

    exit 0
  end

  desc 'Based on tsv files, generate graphs'
  task :graphs do
    system('./scripts/generate_graphs.sh')
    exit 0
  end
end

desc 'Clean results'
task :clean do
  system('rm results/*')
  exit 0
end
