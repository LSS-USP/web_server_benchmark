# This file is the main point to handling ab results data processing.
declare -r r_scripts_path='./data_process/r_script_ab'
declare -r TOTAL_OF_SAMPLES=30
declare -r INCREASE_BY=10

alias Rscript='Rscript --vanilla'

# Take care if you want to change those variables below.
base="$(dirname "$0")"
basepath=$1
outputfolder="$basepath/graphs"

# Include base files
. $base/utils/messages.sh --source-only
. $base/utils/support.sh --source-only
. $base/ab_handler/ab_data_handler.sh --source-only
. $base/ab_handler/ab_graphs.sh --source-only

function data_plots()
{
  local save_base=$1
  local read_from=$1

  ## INCREASE REQUEST
 # save_to=$save_base/increase_request/response_time_by_requests
 # read_from=$save_base/increase_request/tables
 # response_time_by_request_graph $read_from $save_to

  save_to=$save_base/increase_request/boxplots
  read_from=$save_base/increase_request/average_tables
  requests_by_average_response $read_from $save_to

 # ## INCREASE REQUEST WITH KEEP ALIVE
 # save_to=$save_base/increase_request_keep_alive/response_time_by_requests
 # read_from=$save_base/increase_request_keep_alive/tables
 # response_time_by_request_graph $read_from $save_to

  save_to=$save_base/increase_request_keep_alive/boxplots
  read_from=$save_base/increase_request_keep_alive/average_tables
  requests_by_average_response $read_from $save_to
}

function process_data()
{
  local save_base=$2

  ## INCREASE REQUEST
  # Find median value
  local save_to="$save_base/increase_request/tables"
  process_sample_data $1 $save_to 'median'

  # Find average values
  save_to="$save_base/increase_request/average_tables"
  process_sample_data $1 $save_to 'average'

  ## INCREASE REQUEST WITH KEEP ALIVE
  local save_to="$save_base/increase_request_keep_alive/tables"
  process_sample_data $1 $save_to 'median'

  # Find average values
  save_to="$save_base/increase_request_keep_alive/average_tables"
  process_sample_data $1 $save_to 'average'
}

function main()
{
  save_base=$2
  local read_from=$save_to
  process_data $1 $2
  data_plots $2
}

main $1 $2
