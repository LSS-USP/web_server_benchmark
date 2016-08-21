require 'yaml'
require_relative 'common_tasks'
require 'fileutils'

namespace :benchmark do

  include Common

  desc 'Start bench'
  task :run do
    new_path = prepare_results_folder

    experiment_path = experiment_folder(new_path, 'small_static_file')

    %w(event worker prefork).each do |mpm_module|
      system("ansible-playbook -i #{$BENCH_ENV} enable_mpm.yml --extra-vars 'mpm_name=#{mpm_module}'")
      system("ansible-playbook -i #{$BENCH_ENV} execute_benchmark.yml")

      mpm_data_folder = File.join(experiment_path, mpm_module)
      FileUtils::mkdir_p mpm_data_folder
      FileUtils.copy_entry '/tmp/results/', mpm_data_folder
      FileUtils.rm_rf '/tmp/results'
    end

    exit 0
  end

  def prepare_results_folder(result_directory='results')
    Dir.mkdir(result_directory) unless File.directory?(result_directory)

    FileUtils.rm_rf '/tmp/results'
    last_collected = Time.now.strftime("%d-%m-%Y_%H-%M_data")
    FileUtils::mkdir_p File.join(result_directory, last_collected)
    return File.join(result_directory, last_collected)
  end

  def experiment_folder(base_path, experiment_name)
    Dir.mkdir(base_path) unless File.directory?(base_path)

    FileUtils::mkdir_p File.join(base_path, experiment_name)
    return File.join(base_path, experiment_name)
  end

end
