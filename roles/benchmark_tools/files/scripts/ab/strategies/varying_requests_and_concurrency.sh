# Stress different requests by concurrency.
# @param @uri Target uri
function varying_requests_concurrency()
{
  local uri=$1
  local results="$resultspath/varying_requests_concurrency"

  mkdir -p $results

  for requests in {10,100,1000,10000,50000}; do
    for concurrency in {1,10,25,50,100,300,500,1000}; do
      local plot="$results/$requests""x$concurrency.tsv"
      local csv="$results/$requests""x$concurrency.csv"
      local log="$results/$requests""x$concurrency.log"
      ab -n $requests -c $concurrency -g $plot -e $csv -s 50 $uri > $log 2>&1
     done
  done
}
