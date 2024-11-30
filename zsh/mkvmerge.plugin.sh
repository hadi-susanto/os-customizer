mkvmerge-set-default-tracks() {
  # Check if at least 3 parameters are provided
  if [ "$#" -lt 3 ]; then
    echo "Usage: mkvmerge-set-default-tracks <source.mkv> <output.mkv> <track_flag>..."
    echo "Example: mkvmerge-set-default-tracks \"input.mkv\" \"output.mkv\" \"1:0\" \"3:1\""
    return 1
  fi

  # Assign the source and output MKV file parameters
  local source_mkv="$1"
  local output_mkv="$2"
  shift 2

  # Initialize the mkvmerge command
  local mkvmerge_command=("mkvmerge" "-o" "$output_mkv")

  # Append each track flag argument to the command
  for track_flag in "$@"; do
    mkvmerge_command+=("--default-track-flag" "$track_flag")
  done

  # Add the source MKV file to the command
  mkvmerge_command+=("$source_mkv")

  # Print the command for debugging (optional)
  echo "Running command: ${mkvmerge_command[*]}"

  # Execute the command
  "${mkvmerge_command[@]}"
  return $?
}

mkvmerge-batch-edit-tracks() {
  # Check if at least 1 parameter is provided
  if [ "$#" -lt 1 ]; then
    echo "Usage: mkvmerge-batch-edit-tracks <track_flag>..."
    echo "Example: mkvmerge-batch-edit-tracks \"1:0\" \"3:1\" \"4:0\""
    return 1
  fi

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
    echo "Executing mkvmerge-set-default-tracks \"$mkv_file\" \"$output_file\" $@"
    mkvmerge-set-default-tracks "$mkv_file" "$output_file" "$@"
    echo
  done
}

