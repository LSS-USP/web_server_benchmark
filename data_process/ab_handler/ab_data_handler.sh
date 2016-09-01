# Select a specific R script to execute
function run_r_script()
{
  option=$1
  sample_file=$2
  output_data=$3
  case $option in
    median)
      Rscript $r_scripts_path/ab_data_process/find_median_from_samples.R \
           $sample_file \
           $output_data
      ;;
    average)
        Rscript $r_scripts_path/ab_data_process/table_average_request_time.R \
                  $sample_file \
                  $output_data
      ;;
    *)
      complain 'Something wrong with parameters'
      ;;
  esac
}

# Based on a set of csv files, calculate the median and generate a new file
# with all median.
# @param Expecting a relative folder to the results
function process_sample_data()
{
  basepath=$1
  save_to=$2
  operation=$3
  base="$(dirname "$0")"

  mkdir -p $save_to

  # Read sample in the specific folder
  for dir_samples in $basepath/event/increase_request; do
    for sample_dir in $dir_samples/*; do
      sample="$(basename "$sample_dir")"
      event=$sample_dir
      worker=${sample_dir/event/worker}
      prefork=${sample_dir/event/prefork}
      say "Finding median: $sample"
      run_r_script $operation "$event/" "$save_to/$sample""_event.csv" &
      run_r_script $operation "$worker/" "$save_to/$sample""_worker.csv" &
      run_r_script $operation "$prefork/" "$save_to/$sample""_prefork.csv" &
      wait
    done
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
        echo "$table_request"
        #Rscript ./scripts/r_script/table_average_request_time.R \
        #          "$target/$table_request" \
        #          "$outputfolder/$current""_$table_request.csv"
      done
    done
  done
}
