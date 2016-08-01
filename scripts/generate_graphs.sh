function set_configuration()
{
  read_from=$1
  image_output=${read_from/tsv/png}
}

function template_generate()
{
  template=$1
  newfile=$2
  dir=$3
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
}

function fixed_request_varying_concurrency_csv_templates()
{
  basepath=$1
  local outputfolder="$basepath/graphs/fixed_request_varying_concurrency_csv_templates"
  mkdir -p $outputfolder
  i=0

  # ATTENTION: we iterate on 'event' folder, and below we replace the name
  # this only works because we have the same filenames in all folders
  for dir in $basepath/event/fixed_requests_varying_concurrency_*.csv; do
    i=$(( i+= 1 ))
    local newfile="$outputfolder/response_time_by_request_$i"
    # Copy template with new name to graphs folder
    template=$(cat scripts/time_by_served.tpl)

    template_generate "$template" "$newfile" "$dir"
  done
}

function fixed_request_varying_concurrency_tsv_templates()
{
  basepath=$1
  local outputfolder="$basepath/graphs/fixed_request_varying_concurrency_tsv_templates"
  mkdir -p $outputfolder
  i=0

  # ATTENTION: we iterate on 'event' folder, and below we replace the name
  # this only works because we have the same filenames in all folders
  for dir in $basepath/event/fixed_requests_varying_concurrency_*.tsv; do
    i=$(( i+= 1 ))
    local newfile="$outputfolder/response_time_by_request_$i"
    # Copy template with new name to graphs folder
    template=$(cat scripts/response_time_by_request.tpl)

    template_generate "$template" "$newfile" "$dir"
  done
}

function plot_graphs()
{
  basepath=$1

  for folders in $basepath/graphs/*; do
    for files in $folders/*; do
      imagesfolder=$folders/images
      mkdir -p $imagesfolder
      gnuplot $files
      file=${files/.tpl/.png}
      mv $file $imagesfolder 2>/dev/null
    done;
  done;
}

fixed_request_varying_concurrency_tsv_templates $1
fixed_request_varying_concurrency_csv_templates $1
plot_graphs $1
