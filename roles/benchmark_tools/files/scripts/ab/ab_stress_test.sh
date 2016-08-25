#!/bin/bash

currentpath=/srv/scripts
resultspath=$currentpath/results
totalrequests=5000

base="$(dirname "$0")"

. $base/strategies/fixed_requests_varying_concurrency.sh --source-only
. $base/strategies/varying_requests_and_concurrency.sh --source-only
. $base/strategies/keep_alive_fixed_requests_varying_concurrency.sh --source-only
. $base/strategies/increase_request_by_time.sh --source-only
. $base/strategies/increase_request.sh --source-only
. $base/strategies/increase_request_keep_alive.sh --source-only

# Clean everything
function prepare_to_run()
{
  mkdir -p $resultspath
  rm -rf $resultspath/*
}

prepare_to_run
fixed_requests_varying_concurrency $1
# varying_requests_concurrency $1
# keep_alive_with_fixed_requests_varying_concurrency $1
increase_request_by_time $1 $2
increase_request $1 $2
increase_request_with_keep_alive $1 $2
