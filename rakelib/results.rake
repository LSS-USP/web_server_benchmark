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
    process_target('SMALL_STATIC', last, 'small_static_file')

    # Big static data
    process_target('BIG_STATIC', last, 'big_static_file')

    # Small dynamic data
    process_target('SMALL_DYNAMIC', last, 'small_dynamic_file')

    # Big dynamic data
    process_target('BIG_DYNAMIC', last, 'big_dynamic_file')

    exit 0
  end

  def process_target(label, last, path)
    puts '=' * 30
    puts "SCENARIO: #{label} FILE"
    puts '=' * 30

    output_big = "data_processed/#{File.basename(last)}/#{path}"
    FileUtils.mkdir_p output_big
    target = File.join(last, path)
    system("./data_process/ab_results.sh #{target} #{output_big}")
  end

end
