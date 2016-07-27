require 'yaml'
require 'rake'

$BENCH_ENV = ENV.fetch('DEPLOY_TO', 'vms')

desc 'Clean results'
task :clean do
  system('rm results/*')
  exit 0
end
