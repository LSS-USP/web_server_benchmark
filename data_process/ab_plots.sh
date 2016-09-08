# Include base files
base="$(dirname "$0")"
. $base/utils/messages.sh --source-only
. $base/utils/support.sh --source-only
. $base/ab_handler/ab_graphs.sh --source-only
. $base/data_type.sh --source-only

function data_plots()
{
  local save_base=$1
  local read_from=$1

  ## INCREASE REQUEST
  save_to=$save_base/increase_request/response_time_by_requests
  read_from=$save_base/increase_request/tables
  response_time_by_request_graph $read_from $save_to

  save_to=$save_base/increase_request/boxplots
  read_from=$save_base/increase_request/average_tables
  requests_by_average_response $read_from $save_to

  ## INCREASE REQUEST WITH KEEP ALIVE
  save_to=$save_base/increase_request_keep_alive/response_time_by_requests
  read_from=$save_base/increase_request_keep_alive/tables
  response_time_by_request_graph $read_from $save_to

  save_to=$save_base/increase_request_keep_alive/boxplots
  read_from=$save_base/increase_request_keep_alive/average_tables
  requests_by_average_response $read_from $save_to
}

data_plots $1
