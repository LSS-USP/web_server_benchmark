save_to='save_path'
read_from='read_path'

function set_configuration()
{
  read_from=$1
  image_output=${read_from/tsv/png}

read -r -d '' GNUPLOTOUTPUT <<HereIsTheGnuFile
set terminal png size 1280,720
set size 1, 1
set output '$image_output'
set title 'Benchmark testing'
set key left top
set grid y
set xdata time
set timefmt '%s'
set format x '%S'
set xlabel 'seconds'
set ylabel 'response time (ms)'
set datafile separator '\t'
plot '$read_from' every ::2 using 2:5 title 'response time' with points
exit
HereIsTheGnuFile
}

function plot_graphs()
{
  local results=$1
  for entry in $results/*
  do
    save_to=${entry/tsv/p}
    read_from=$entry
    set_configuration $read_from
    echo "$GNUPLOTOUTPUT" > $save_to
    gnuplot $save_to
  done;
}

plot_graphs 'results'
