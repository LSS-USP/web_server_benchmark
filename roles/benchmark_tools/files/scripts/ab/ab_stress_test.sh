#!/bin/bash

currentpath=/srv/scripts
resultspath=$currentpath/results
totalrequests=5000

base="$(dirname "$0")"

. $base/strategies/fixed_requests_varying_concurrency.sh --source-only
. $base/strategies/varying_requests_and_concurrency.sh --source-only
. $base/strategies/keep_alive_fixed_requests_varying_concurrency.sh --source-only

# Clean everything
function prepare_to_run()
{
  mkdir -p $resultspath
  rm -rf $resultspath/*
}

prepare_to_run
fixed_requests_varying_concurrency $1
varying_requests_concurrency $1
keep_alive_with_fixed_requests_varying_concurrency $1
