# Function responsible to stress the application with ab.
# @param @uri Target uri
# @param @increase_by Increase rate to request
# @param @concurrency Concurrency, default is 100
function increase_request()
{
  local uri=$1
  local increase_by=$2
  local concurrency=$3
  local results="$resultspath/increase_request"

  increase_by=${increase_by:=200}
  concurrency=${concurrency:=100}
  # TODO: Add a increase_by verification, it should be bigger than concurrency

  mkdir -p $results

  # Start warm up
  warm_up $uri $increase_by $concurrency

  # Hammering Apache!
  for (( hammered=1; hammered <= 10; hammered++ )); do

    local requests=$(( hammered * increase_by ))

    # Preparing samples folder
    currentfolder="$results/$requests"
    mkdir -p $currentfolder

    # 30 samples for each test
    local samples=0
    while (( samples < 30 )); do
      local plot="$currentfolder/$samples.tsv"
      local csv="$currentfolder/$samples.csv"
      ab -n $requests -c $concurrency -g $plot -e $csv -s 50 $uri > /dev/null 2>&1
      samples=$(( samples + 1 ))
    done
  done
}
