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
  task :processall do
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
    data_handler('SMALL_STATIC', 'all', last, 'small_static_file')
    # Big static data
    data_handler('BIG_STATIC', 'all', last, 'big_static_file')
    # Small dynamic data
    data_handler('SMALL_DYNAMIC', 'all', last, 'small_dynamic_file')
    # Big dynamic data
    data_handler('BIG_DYNAMIC', 'all', last, 'big_dynamic_file')

    exit 0
  end

  desc 'Generate graphs'
  task :plots do
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
    data_handler('SMALL_STATIC', 'plots', last, 'small_static_file')
    # Big static data
    data_handler('BIG_STATIC', 'plots', last, 'big_static_file')
    # Small dynamic data
    data_handler('SMALL_DYNAMIC', 'plots', last, 'small_dynamic_file')
    # Big dynamic data
    data_handler('BIG_DYNAMIC', 'plots', last, 'big_dynamic_file')

    exit 0
  end

  desc 'Generate graphs'
  task :data_process do
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
    data_handler('SMALL_STATIC', 'process_data', last, 'small_static_file')
    # Big static data
    data_handler('BIG_STATIC', 'process_data', last, 'big_static_file')
    # Small dynamic data
    data_handler('SMALL_DYNAMIC', 'process_data', last, 'small_dynamic_file')
    # Big dynamic data
    data_handler('BIG_DYNAMIC', 'process_data', last, 'big_dynamic_file')

    exit 0
  end

  def data_handler(label, action, read_from, save_to = '')
    puts '=' * 30
    puts "SCENARIO: #{label} FILE"
    puts '=' * 30

    output = "data_processed/#{File.basename(read_from)}/#{save_to}"
    #FileUtils.mkdir_p output
    target = File.join(read_from, save_to)
    if action =~ /plots/
      script = "./data_process/ab_plots.sh #{output}"
    elsif action =~ /process_data/
      script = "./data_process/ab_data_process.sh #{target} #{output}"
    else
      script = "./data_process/ab_data_process.sh #{target} #{output} && "
      script += "./data_process/ab_plots.sh #{output}"
    end
    system(script)
  end

end
