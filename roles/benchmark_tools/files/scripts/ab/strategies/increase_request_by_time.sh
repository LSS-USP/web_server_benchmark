# Function responsible to stress the application with ab.
# @param @uri Target uri

declare -r minute=60

function increase_request_by_time()
{
  local uri=$1
  local increase_by=${2:=200}
  local results="$resultspath/increase_request_by_time"

  mkdir -p $results

  local concurrency=100

  for (( hammered=1; hammered <= 10; hammered++ )); do
    SECONDS=0

    local requests=$(( hammered * increase_by ))

    currentfolder="$results/$requests"
    mkdir -p $currentfolder

    while (( SECONDS < minute )); do
      local plot="$currentfolder/$SECONDS.tsv"
      local log="$currentfolder/$SECONDS.log"
      ab -n $requests -c $concurrency -g $plot -s 50 -k $uri > $log 2>&1
    done
  done
}
