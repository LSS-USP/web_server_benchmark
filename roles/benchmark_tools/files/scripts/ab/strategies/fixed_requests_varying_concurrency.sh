# Function responsible to stress the application with ab.
# @param @uri Target uri
function fixed_requests_varying_concurrency()
{
  local uri=$1
  local requests=$2
  local results="$resultspath/fixed_requests_varying_concurrency"
  requests=${requests:=300}

  mkdir -p $results

  for concurrency in {1,10,25,50,100,300}; do
    local plot="$results/$totalrequests""_$concurrency.tsv"
    local csv="$results/$totalrequests""_$concurrency.csv"
    select_ab_strategies 'simple' $totalrequests $concurrency $plot $csv $uri
  done
}
