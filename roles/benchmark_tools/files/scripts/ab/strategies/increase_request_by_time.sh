# Function responsible to stress the application with ab.
# @param @uri Target uri

function increase_request_by_time()
{
  local uri=$1
  local increase_by=${2:=200}
  local results="$resultspath/increase_request_by_time"

  mkdir -p $results

  local concurrency=100

  for (( hammered=1; hammered <= 10; hammered++ )); do

    local requests=$(( hammered * increase_by ))

    currentfolder="$results/$requests"
    mkdir -p $currentfolder
    i=0
    while (( i < 20 )); do
      local plot="$currentfolder/$i.tsv"
      local log="$currentfolder/$i.log"
      ab -n $requests -c $concurrency -g $plot -s 50 -k $uri > $log 2>&1
      i=$(( i + 1 ))
      sleep 1
    done
  done
}
