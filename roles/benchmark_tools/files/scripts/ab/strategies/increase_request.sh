# Copyright (C) 2016 Rodrigo Siqueira
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 3 as
# published by the Free Software Foundation.

# Function responsible to stress the application with ab.
# @param @uri Target uri
# @param @increase_by Increase rate to request
# @param @concurrency Concurrency, default is 100
function increase_request()
{
  local uri=$1
  local increase_by=$2
  local concurrency=$3
  local select=$4
  local results=$5

  # If any value is null, set a default value
  concurrency=${concurrency:=100}
  increase_by=${increase_by:="$concurrency"}
  select=${select:='simple'}
  results=${results:="$resultspath/increase_request"}

  hammering_preparation $uri $results $increase_by $concurrency

  # Hammering Apache!
  for (( hammered=1; hammered <= REQUEST_INTERACTIONS; hammered++ )); do
    local requests=$(( hammered * increase_by ))

    # Request have to be greater than concurrency
    if [ $requests -lt $concurrency ]; then
      continue
    fi

    # Preparing samples folder
    currentfolder="$results/$requests"
    mkdir -p $currentfolder

    execute_samples $uri $concurrency $requests $select $currentfolder
  done
}

function hammering_preparation()
{
  local uri=$1
  local results=$2
  local increase_by=$3
  local concurrency=$4

  mkdir -p $results

  # Start warm up
  warm_up $uri $increase_by $concurrency
}

# Same request executed 'n' times, basically it is the samples.
function execute_samples()
{
  local uri=$1
  local concurrency=$2
  local requests=$3
  local select=$4
  local currentfolder=$5

  # Samples for each test
  local samples=0
  while (( samples < TOTAL_OF_SAMPLES )); do
    local plot="$currentfolder/$samples.tsv"
    local csv="$currentfolder/$samples.csv"
    select_ab_strategies $uri $requests $concurrency $select $plot $csv
    samples=$(( samples + 1 ))
  done
}
