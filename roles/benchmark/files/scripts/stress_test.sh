#!/bin/bash

currentpath=/srv/scripts
resultspath=$currentpath/results
totalrequests=5000

# Clean everything
function prepare_to_run()
{
  mkdir -p $resultspath
  rm -rf $resultspath/*
}

# Function responsible to stress the application with ab.
# @param @mpm_type Type of MPM strategy adopted.
# @param @uri Target uri
function stress_with_ab()
{
  local mpm_type=$1
  local uri=$2
  prepare_to_run
  for i in {1,10,25,50,100,1000}; do
    local plot="$resultspath/gnuplot_"$mpm_type"_"$i".tsv"
    local csv="$resultspath/csv_"$mpm_type"_"$i".csv"
    ab -n $totalrequests -c $i -g $plot -e $csv $uri
  done
}

stress_with_ab $1 $2
