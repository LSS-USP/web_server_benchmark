function format_target_name()
{
  declare -n ref=$1
  targetname="$(basename "$ref")"
  targetname=${targetname/.csv/''}
  ref=$targetname
}

# Generate graphs from binned files
# @param Expecting a base folder
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
    targetname=$dir
    format_target_name targetname

    local newfile="$outputfolder/response_time_by_request_$targetname.png"

    # Replace paths
    event=$dir
    worker=${dir/event/worker}
    prefork=${dir/event/prefork}
    echo "Generating graphs: $newfile"
    Rscript --vanilla $base/r_script/binned_data.R \
                                            $newfile $event $worker $prefork
  done
}

# Generate graphs from binned files
function increase_request_with_keep_alive()
{
  basepath=$1
  local outputfolder="$basepath/graphs/increase_request_with_keep_alive"
  mkdir -p $outputfolder

  base="$(dirname "$0")"

  i=0
  # ATTENTION: we iterate on 'event' folder, and below we replace the name
  # this only works because we have the same filenames in all folders
  for dir in $basepath/event/increase_request/*.csv; do
    targetname=$dir
    format_target_name targetname
    local newfile="$outputfolder/response_time_by_request_keep_alive_$targetname.png"

    # Replace paths
    event=$dir
    worker=${dir/event/worker}
    prefork=${dir/event/prefork}
    echo "Generating graphs: $targetname"
    Rscript --vanilla $base/r_script/binned_data.R \
                                            $newfile $event $worker $prefork
  done
}

# Generate graphs from process data
function process_data_requests_by_average_response()
{
  basepath=$1
  base="$(dirname "$0")"
  local outputfolder="$basepath/graphs/requests_by_average_response/tables"
  declare -a location_samples
  i=0

  mkdir -p $outputfolder

  #First step: Process data
  for dir in $basepath/event/increase_request_by_time; do
    # Replace paths
    for current in {event,worker,prefork}; do
      target=${dir/event/$current}
      echo "Generating data table to $current..."
      for subdirs in $target/*; do
        table_request="$(basename "$subdirs")"
        Rscript ./scripts/r_script/table_average_request_time.R \
                  "$target/$table_request" \
                  "$outputfolder/$current""_$table_request.csv"
      done
    done
  done
}

function requests_by_average_response()
{
  basepath=$1
  base="$(dirname "$0")"
  local outputfolder="$basepath/graphs/requests_by_average_response/tables"
  save_to="$(dirname "$outputfolder")"
  Rscript --vanilla scripts/r_script/average_time_per_request.R '10000' \
                                              $outputfolder $save_to
}

increase_request $1
process_data_requests_by_average_response $1
requests_by_average_response $1
