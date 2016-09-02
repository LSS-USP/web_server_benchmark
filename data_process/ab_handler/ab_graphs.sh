# Generate graphs from binned files, basically we work on preprocessed data
# @param Expecting a base folder
function response_time_by_request_graph()
{
  local basepath=$1
  local save_to=$2

  mkdir -p $save_to

  for mpm_file in $basepath/*_event.csv; do
    targetname=$mpm_file
    format_target_name targetname
    targetname=${targetname/_event/''}

    local newfile="$save_to/response_time_by_request_$targetname.png"

    # Replace paths
    event=$mpm_file
    worker=${mpm_file/event/worker}
    prefork=${mpm_file/event/prefork}
    say "Generating graphs: $newfile"
    Rscript $r_scripts_path/ab_graphs_generate/binned_data.R \
                                            $newfile $event $worker $prefork
  done
}

function requests_by_average_response()
{
  local read_from=$1
  local save_to=$2
  local increase_by=$3

  mkdir -p $save_to

  Rscript $r_scripts_path/ab_graphs_generate/average_time_per_request.R '10000' \
                                                  $read_from $save_to
}
