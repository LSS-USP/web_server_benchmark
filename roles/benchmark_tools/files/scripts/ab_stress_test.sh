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
# @param @uri Target uri
function fixed_requests_varying_concurrency()
{
  local uri=$1

  for i in {1,10,25,50,100,300,500,1000}; do
    local plot="$resultspath/fixed_requests_varying_concurrency_$i.tsv"
    local csv="$resultspath/fixed_requests_varying_concurrency_$i.csv"
    local log="$resultspath/fixed_requests_varying_concurrency_$i.log"
    ab -n $totalrequests -c $i -g $plot -e $csv -s 50 $uri > log 2>&1
  done
}

# Stress different requests by concurrency.
# @param @uri Target uri
function varying_requests_concurrency()
{
  local uri=$1

  for requests in {10,100,1000,10000,50000}; do
    for concurrency in {1,10,25,50,100,300,500,1000}; do
      local plot="$resultspath/varying_requests_concurrency_$requests""x$concurrency.tsv"
      local csv="$resultspath/varying_requests_concurrency_$requests""x$concurrency.csv"
      local log="$resultspath/varying_requests_concurrency_$i.log"
      ab -n $totalrequests -c $i -g $plot -e $csv -s 50 $uri > $log 2>&1
     done
  done
}

# Function responsible to stress the application with ab.
# @param @uri Target uri
function keep_alive_with_fixed_requests_varying_concurrency()
{
  local uri=$1

  for i in {1,10,25,50,100,300,500,1000}; do
    local plot="$resultspath/keep_alive_$i.tsv"
    local csv="$resultspath/keep_alive_$i.csv"
    local log="$resultspath/keep_alive_$i.log"
    ab -n $totalrequests -c $i -g $plot -e $csv -s 50 -k $uri > $log 2>&1
  done
}

prepare_to_run
fixed_requests_varying_concurrency $1
varying_requests_concurrency $1
keep_alive_with_fixed_requests_varying_concurrency $1
