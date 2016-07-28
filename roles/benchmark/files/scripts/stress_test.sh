
# Function responsible to stress the application with ab.
# @param @mpm_type Type of MPM strategy adopted.
# @param @uri Target uri
function stress_with_ab()
{
  local mpm_type=$1
  local uri=$2
  mkdir -p results
  for i in {1,10,25,50,100,1000}; do
    ab -n 9000 -c $i -g "results/gnuplot_"$mpm_type"_"$i".tsv" $uri
  done
}

stress_with_ab $1 $2
