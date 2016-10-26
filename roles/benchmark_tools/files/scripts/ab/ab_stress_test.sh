#!/bin/bash

# Copyright (C) 2016 Rodrigo Siqueira
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 3 as
# published by the Free Software Foundation.

declare -r REQUEST_INTERACTIONS=10
declare -r TOTAL_OF_SAMPLES=30

currentpath=/srv/scripts
resultspath=$currentpath/results
totalrequests=1000

base="$(dirname "$0")"

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
}

prepare_to_run
strategies_varying_requests $1 $2
