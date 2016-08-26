# Function responsible to stress the application with ab.
# @param @uri Target uri

function increase_request()
{
  local uri=$1
  local increase_by=${2:=200}
  local results="$resultspath/increase_request_with_samples"

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
      local csv="$currentfolder/$i.csv"
      ab -n $requests -c $concurrency -g $plot -e $csv -s 50 -k $uri > $log 2>&1
      i=$(( i + 1 ))
      sleep 2
    done
  done
}
