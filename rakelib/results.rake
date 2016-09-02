require 'fileutils'

namespace :results do

  desc 'Completely clean results'
  task :hardclean do
    FileUtils::rm_rf(Dir['results/*'])
    FileUtils::touch 'results/.keep'
    exit 0
  end

  desc 'Move results to tmp'
  task :move do
    FileUtils.mkdir_p '/tmp/results'
    FileUtils.mv Dir.glob('results/*'), '/tmp/results'
    exit 0
  end

  desc 'Based on tsv files, generate graphs'
  task :process do
    folders = []
    begin
      load '.last_execution'
    rescue LoadError
      last = Dir.glob('results/*').max_by {|file| File.mtime(file)}
    end
    last = ENV.fetch('LAST_EXECUTION', last)

    # Set up result folder
    output = "data_processed/#{File.basename(last)}"
    FileUtils.mkdir_p output

    # Small static data
    puts '=' * 30
    puts "SCENARIO: SMALL STATIC FILE"
    puts '=' * 30
    output_small = "data_processed/#{File.basename(last)}/small_static_file"
    FileUtils.mkdir_p output_small
    small = File.join(last, 'small_static_file')
    system("./data_process/ab_results.sh #{small} #{output_small}")

    # Big static data
    puts '=' * 30
    puts "SCENARIO: BIG STATIC FILE"
    puts '=' * 30

    output_big = "data_processed/#{File.basename(last)}/big_static_file"
    FileUtils.mkdir_p output_big
    big = File.join(last, 'big_static_file')
    system("./data_process/ab_results.sh #{big} #{output_big}")

    exit 0
  end

end
