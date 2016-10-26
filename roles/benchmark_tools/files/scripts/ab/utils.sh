# Copyright (C) 2016 Rodrigo Siqueira
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 3 as
# published by the Free Software Foundation.

function select_ab_strategies()
{
  local uri=$1
  local requests=$2
  local concurrency=$3
  local option=$4
  local plot=$5
  local csv=$6

  case $option in
    simple)
      ab -n $requests -c $concurrency -g $plot -e $csv -s 50 $uri > /dev/null 2>&1
      ;;
    withkeepalive)
      ab -n $requests -c $concurrency -g $plot -e $csv -s 50 -k $uri > /dev/null 2>&1
      ;;
    warmup)
      ab -n $requests -c $concurrency -s 50 $uri > /dev/null 2>&1
      ;;
    *)
      complain 'Running default'
      ab -n $requests -c $concurrency $uri > /dev/null 2>&1
      ;;
  esac
}

# Warm up Apache before start to work
function warm_up()
{
  local uri=$1
  local increase_by=$2
  local concurrency=$3
  increase_by=${increase_by:=200}
  concurrency=${concurrency:=100}

  for (( warmup=1; warmup <= 10; warmup++ )); do
    local requests=$(( warmup * increase_by ))
    select_ab_strategies $uri $requests $concurrency 'warmup' $plot $csv
  done
}
