# Include base files
base="$(dirname "$0")"
. $base/utils/messages.sh --source-only
. $base/utils/support.sh --source-only
. $base/ab_handler/ab_data_handler.sh --source-only
. $base/data_type.sh --source-only

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

process_data $1 $2
