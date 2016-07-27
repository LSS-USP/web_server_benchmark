
namespace :results do

  desc 'Completely clean results'
  task :hardclean do
    system('rm -rf results/*')
    exit 0
  end

  desc 'Move results to tmp'
  task :move do
    system('mkdir /tmp/results')
    system('mv results/* /tmp/results')
    exit 0
  end

  desc 'Based on tsv files, generate graphs'
  task :graphs do
    system('./scripts/generate_graphs.sh')
    exit 0
  end

end
