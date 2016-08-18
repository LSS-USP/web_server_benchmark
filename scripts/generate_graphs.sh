
function increase_request()
{
  basepath=$1
  local outputfolder="$basepath/graphs/increase_request"
  mkdir -p $outputfolder

  base="$(dirname "$0")"

  i=0
  # ATTENTION: we iterate on 'event' folder, and below we replace the name
  # this only works because we have the same filenames in all folders
  for dir in $basepath/event/increase_request/*.csv; do
    i=$(( i+= 1 ))
    local newfile="$outputfolder/response_time_by_request_$i.png"
    # Replace paths
    event=${dir/event/event}
    worker=${dir/event/worker}
    prefork=${dir/event/prefork}
    echo "Generating graphs: $i"
    Rscript --vanilla $base/r_script/binned_data.R $newfile $event $worker $prefork
  done
}

increase_request $1
