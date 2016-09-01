# This file is the main point to handling ab results data processing.
declare -r r_scripts_path='./data_process/r_script_ab'
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

function main()
{
  # Find median value
  save_to="$outputfolder/increase_request/tables"
  process_sample_data $1 $save_to 'median'

  save_to="$outputfolder/increase_request/"
  response_time_by_request_graph $1 $save_to

 # save_to="$outputfolder/requests_by_average_response/tables"
 # process_sample_data $1 $save_to 'average'
}

main $1
