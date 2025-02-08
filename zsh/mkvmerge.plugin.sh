mkvmerge-process-file() {
  # Check if at least 4 parameters are provided
  if [ "$#" -lt 4 ]; then
    echo "Usage: mkvmerge-process-file <source.mkv> <output.mkv> <mkvmerge-option> <track_flag>..."
    echo "Example: mkvmerge-process-file \"input.mkv\" \"output.mkv\" --default-track-flag \"1:0\" \"3:1\""
    return 1
  fi

  # Assign parameters to local variable for easier reading
  local source_mkv="$1"
  local output_mkv="$2"
  local option="$3"
  shift 3

  # Initialize the mkvmerge command
  local mkvmerge_command=("mkvmerge" "-o" "$output_mkv")

  # Append each track flag argument to the command
  for track_flag in "$@"; do
    mkvmerge_command+=("$option" "$track_flag")
  done

  # Add the source MKV file to the command
  mkvmerge_command+=("$source_mkv")

  # Print the command for debugging (optional)
  echo "Executing command: ${mkvmerge_command[*]}"

  # Execute the command
  "${mkvmerge_command[@]}"
  return $?
}

mkvmerge-batch-process() {
  # Check if at least 2 parameters is provided
  if [ "$#" -lt 2 ]; then
    echo "Usage: mkvmerge-batch-process <mkvmerge-option> <track_flag>..."
    echo "Example: mkvmerge-batch-process --default-track-flag \"1:0\" \"3:1\" \"4:0\""
    return 1
  fi

  # Assign parameters to local variable for easier reading
  local option="$1"
  shift 1

  local output_dir;
  if [[ -z "$MKVMERGE_DEFAULT_OUTPUT_DIR" ]]; then
    output_dir="output"
  else
    output_dir="$MKVMERGE_DEFAULT_OUTPUT_DIR"
  fi

  # Create the output folder if it doesn't exist
  echo "Creating output dir: $output_dir"
  mkdir -p "$output_dir"

  # Iterate over all .mkv files in the current directory
  for mkv_file in *.mkv; do
    if ! [[ -f "$mkv_file" ]]; then
      echo "$mkv_file isn't a file, skipping it...'"
      echo

      continue
    fi

    # Calculate the output file path
    local output_file="$output_dir/${mkv_file}"

    # Call mkvmerge-set-default-tracks with the parameters
    echo "Executing mkvmerge-batch-process \"$mkv_file\" \"$output_file\" $option $@"
    mkvmerge-process-file "$mkv_file" "$output_file" "$option" "$@"
    echo
  done
}

mkvmerge-batch-default-tracks() {
  # Check if at least 1 parameter1 is provided
  if [ "$#" -lt 1 ]; then
    echo "Usage: mkvmerge-batch-default-tracks <track_flag>..."
    echo "Example: mkvmerge-batch-default-tracks \"1:0\" \"3:1\" \"4:0\""
    return 1
  fi

  mkvmerge-batch-process "--default-track-flag" "$@"
}

mkvmerge-batch-forced-displays() {
  # Check if at least 1 parameter1 is provided
  if [ "$#" -lt 1 ]; then
    echo "Usage: mkvmerge-batch-forced-displays <track_flag>..."
    echo "Example: mkvmerge-batch-forced-displays \"1:0\" \"3:1\" \"4:0\""
    return 1
  fi

  mkvmerge-batch-process "--forced-display-flag" "$@"
}

