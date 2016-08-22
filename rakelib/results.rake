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
  task :graphs do
    folders = []

    last = Dir.glob('results/*').max_by {|file| File.mtime(file)}

    # Small static data
    small = File.join(last, 'small_static_file')
    system("./scripts/generate_graphs.sh #{small}")

    # Big static data
    big = File.join(last, 'big_static_file')
    system("./scripts/generate_graphs.sh #{big}")

    exit 0
  end

end
