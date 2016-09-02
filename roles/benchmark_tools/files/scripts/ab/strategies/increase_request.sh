# Function responsible to stress the application with ab.
# @param @uri Target uri
# @param @increase_by Increase rate to request
# @param @concurrency Concurrency, default is 100
function increase_request()
{
  local uri=$1
  local increase_by=$2
  local concurrency=$3
  local select=$4
  local results=$5

  increase_by=${increase_by:=200}
  concurrency=${concurrency:=100}
  select=${select:='simple'}
  results=${results:="$resultspath/increase_request"}

  mkdir -p $results

  # Start warm up
  warm_up $uri $increase_by $concurrency

  # Hammering Apache!
  for (( hammered=1; hammered <= INCREASE_BY; hammered++ )); do

    local requests=$(( hammered * increase_by ))

    # Preparing samples folder
    currentfolder="$results/$requests"
    mkdir -p $currentfolder

    # 30 samples for each test
    local samples=0
    while (( samples < TOTAL_OF_SAMPLES )); do
      local plot="$currentfolder/$samples.tsv"
      local csv="$currentfolder/$samples.csv"
      select_ab_strategies $select $requests $concurrency $plot $csv $uri
      samples=$(( samples + 1 ))
    done
  done
}
