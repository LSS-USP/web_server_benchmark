BLUECOLOR="\033[1;34;49m%s\033[m\n"
REDCOLOR="\033[1;31;49m%s\033[m\n"
GREENCOLOR="\033[1;32;49m%s\033[m\n"

# Print normal message (e.g info messages). This function verifies if stdout
# is open and print it with color, otherwise print it without color.
# @param $@ it receives text message to be printed.
function say()
{
  message="$@"
  if [ -t 1 ]; then
    printf $GREENCOLOR "$message"
  else
    echo "$message"
  fi
}

# Print error message. This function verifies if stdout is open and print it
# with color, otherwise print it without color.
# @param $@ it receives text message to be printed.
function complain()
{
  message="$@"
  if [ -t 1 ]; then
    printf $REDCOLOR "$message"
  else
    echo "$message"
  fi
}
