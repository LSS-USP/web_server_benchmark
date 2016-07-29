save_to='save_path'
read_from='read_path'

function set_configuration()
{
  read_from=$1
  image_output=${read_from/tsv/png}
}

function fixed_request_varying_concurrency_csv_templates()
{
  local outputfolder="graphs/fixed_request_varying_concurrency_csv_templates"
  mkdir -p $outputfolder
  i=0

  # ATTENTION: we iterate on 'event' folder, and below we replace the name
  # this only works because we have the same filenames in all folders
  for dir in results/event/fixed_requests_varying_concurrency_*.csv; do
    i=$(( i+= 1 ))
    local newfile="$outputfolder/response_time_by_request_$i"
    # Copy template with new name to graphs folder
    template=$(cat time_by_served.tpl)

    # Replace basic information
    template=${template/__IMAGE_PATH__/"$newfile"}

    # Replace data paths
    # ORDER IS IMPORTANT HERE!
    for folder in {event,prefork,worker}; do
      # Replace paths in the template
      current_path=${dir/event/$folder}
      to_replace="__"${folder^^}"_FILE__"
      template=${template/$to_replace/$current_path}
    done
    echo "$template" > "$newfile.tpl"
  done
}

function fixed_request_varying_concurrency_tsv_templates()
{
  local outputfolder="graphs/fixed_request_varying_concurrency_tsv_templates"
  mkdir -p $outputfolder
  i=0

  # ATTENTION: we iterate on 'event' folder, and below we replace the name
  # this only works because we have the same filenames in all folders
  for dir in results/event/fixed_requests_varying_concurrency_*.tsv; do
    i=$(( i+= 1 ))
    local newfile="$outputfolder/response_time_by_request_$i"
    # Copy template with new name to graphs folder
    template=$(cat response_time_by_request.tpl)

    # Replace basic information
    template=${template/__IMAGE_PATH__/"$newfile"}

    # Replace data paths
    # ORDER IS IMPORTANT HERE!
    for folder in {event,prefork,worker}; do
      # Replace paths in the template
      current_path=${dir/event/$folder}
      to_replace="__"${folder^^}"_FILE__"
      template=${template/$to_replace/$current_path}
    done
    echo "$template" > "$newfile.tpl"
  done
}

function plot_graphs()
{
  for folders in graphs/*; do
    for files in $folders/*; do
      gnuplot $files
    done;
  done;
}

fixed_request_varying_concurrency_tsv_templates
fixed_request_varying_concurrency_csv_templates
plot_graphs
