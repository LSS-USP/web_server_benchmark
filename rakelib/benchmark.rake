require 'yaml'
require_relative 'common_tasks'

namespace :benchmark do

  include Common

  desc 'Start bench'
  task :run do
    vm_define = "config/#{$BENCH_ENV}/basic/machine_define.yml"

    # XXX: Please, rewrite it.
    puts('=' * 30)
    puts ('>>>> EVENT')
    system("ansible-playbook -i #{$BENCH_ENV} enable_event.yml")
    system("ansible-playbook -i #{$BENCH_ENV} execute_benchmark.yml")

    last_collected = Time.now.strftime("%d-%m-%Y_%H-%M")
    last_collected = "results/#{last_collected}_data"

    event = "#{last_collected}/event"
    system("mkdir -p #{event}")
    system("cp /tmp/fetched/benchmark/srv/scripts/results/* #{event}")
    system("rm -rf /tmp/fetched")

    puts('=' * 30)
    puts ('>>>> WORKER')
    system("ansible-playbook -i #{$BENCH_ENV} enable_worker.yml")
    system("ansible-playbook -i #{$BENCH_ENV} execute_benchmark.yml")

    worker = "#{last_collected}/worker"
    system("mkdir -p #{worker}")
    system("cp /tmp/fetched/benchmark/srv/scripts/results/* #{worker}")
    system("rm -rf /tmp/fetched")

    puts('=' * 30)
    puts ('>>>> PREFORK')
    system("ansible-playbook -i #{$BENCH_ENV} enable_prefork.yml")
    system("ansible-playbook -i #{$BENCH_ENV} execute_benchmark.yml")

    prefork = "#{last_collected}/prefork"
    system("mkdir -p #{prefork}")
    system("cp /tmp/fetched/benchmark/srv/scripts/results/* #{prefork}")
    system("rm -rf /tmp/fetched")

    exit 0
  end

end
