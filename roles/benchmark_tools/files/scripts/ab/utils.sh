# Select a specific R script to execute
function select_ab_strategies()
{
  local option=$1
  local requests=$2
  local concurrency=$3
  local plot=$4
  local csv=$5
  local uri=$6

  concurrency=${concurrency:=200}
  requests=${requests:=100}

  case $option in
    simple)
      ab -n $requests -c $concurrency -g $plot -e $csv -s 50 $uri > /dev/null 2>&1
      ;;
    withkeepalive)
      ab -n $requests -c $concurrency -g $plot -e $csv -s 50 -k $uri > /dev/null 2>&1
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
  local i=1
  increase_by=${increase_by:=200}
  concurrency=${concurrency:=100}

  while (( i < 11 )); do
    local requests=$(( i * increase_by ))
    ab -n $requests -c $concurrency -s 50 $uri > /dev/null 2>&1
    i=$(( i + 1 ))
  done
}
