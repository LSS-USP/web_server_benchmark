require 'yaml'
require 'rake'

begin
  load 'local.rake'
rescue LoadError
    # nothing
end

$BENCH_ENV = ENV.fetch('DEPLOY_TO', 'vms')
