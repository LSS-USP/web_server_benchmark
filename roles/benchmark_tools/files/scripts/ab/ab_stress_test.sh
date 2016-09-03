#!/bin/bash

declare -r TOTAL_OF_SAMPLES=30
declare -r INCREASE_BY=10

currentpath=/srv/scripts
resultspath=$currentpath/results
totalrequests=5000

base="$(dirname "$0")"

. $base/strategies/fixed_requests_varying_concurrency.sh --source-only
. $base/strategies/varying_requests_and_concurrency.sh --source-only
. $base/strategies/keep_alive_fixed_requests_varying_concurrency.sh --source-only
. $base/strategies/increase_request.sh --source-only
. $base/utils.sh --source-only

# Clean everything
function prepare_to_run()
{
  mkdir -p $resultspath
  rm -rf $resultspath/*
}

function strategies_varying_requests()
{
  local uri=$1
  local increase_by=$2
  local save_to=$resultspath/increase_request

  increase_request $uri $increase_by 100 'simple' $save_to

  save_to=$resultspath/increase_request_keep_alive
  increase_request $uri $increase_by 100 'withkeepalive' $save_to
}

prepare_to_run
strategies_varying_requests $1 $2
