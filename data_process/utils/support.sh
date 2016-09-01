function format_target_name()
{
  declare -n ref=$1
  targetname="$(basename "$ref")"
  targetname=${targetname/.csv/''}
  ref=$targetname
}
