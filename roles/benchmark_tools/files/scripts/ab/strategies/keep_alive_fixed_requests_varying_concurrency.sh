# Function responsible to stress the application with ab.
# @param @uri Target uri
function keep_alive_with_fixed_requests_varying_concurrency()
{
  local uri=$1
  local results="$resultspath/keep_alive_fixed_requests_varying_concurrency"

  mkdir -p $results

  for i in {1,10,25,50,100,300,500,1000}; do
    local plot="$results/$totalrequests""_$i.tsv"
    local csv="$results/$totalrequests""_$i.csv"
    local log="$results/$totalrequests""_$i.log"
    ab -n $totalrequests -c $i -g $plot -e $csv -s 50 -k $uri > $log 2>&1
  done
}
