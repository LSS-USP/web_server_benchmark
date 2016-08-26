# Function responsible to stress the application with ab.
# @param @uri Target uri

function increase_request_with_keep_alive()
{
  local uri=$1
  local increase_by=${2:=200}
  local results="$resultspath/increase_request_with_keep_alive"

  mkdir -p $results

  local concurrency=100

  for (( hammered=1; hammered <= 10; hammered++ )); do

    local requests=$(( hammered * increase_by ))

    local plot="$results/$requests.tsv"
    local log="$results/$requests.log"
    local csv="$results/$requests.csv"
    ab -n $requests -c $concurrency -g $plot -e $csv -s 50 $uri -k > $log 2>&1
    sleep 2
  done
}
