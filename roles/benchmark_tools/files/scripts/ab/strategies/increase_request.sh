# Function responsible to stress the application with ab.
# @param @uri Target uri

function increase_request()
{
  local uri=$1
  local increase_by=${2:=200}
  local results="$resultspath/increase_request"

  mkdir -p $results

  local concurrency=100

  for (( hammered=1; hammered <= 10; hammered++ )); do

    local requests=$(( hammered * increase_by ))

    local plot="$results/$hammered.tsv"
    local log="$results/$hammered.log"
    local csv="$results/$hammered.csv"
    ab -n $requests -c $concurrency -g $plot -e $csv -s 50 $uri > $log 2>&1
    sleep 5
  done
}
