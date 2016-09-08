# This file is the main point to handling ab results data processing.
declare -r r_scripts_path='./data_process/r_script_ab'
declare -r TOTAL_OF_SAMPLES=30
declare -r INCREASE_BY=10

alias Rscript='Rscript --vanilla'

# Take care if you want to change those variables below.
base="$(dirname "$0")"
basepath=$1
outputfolder="$basepath/graphs"
