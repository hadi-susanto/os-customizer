#!/bin/bash

# Global Variable(s)
if [[ -z "$DEADBEEF_INSTALL_DIR" ]]; then
  # Unless defined we will assume sdkman cloned as our directory siblings
  DEADBEEF_INSTALL_DIR=$(readlink -f "$PWD/..")/deadbeef
fi

deadbeef_temp_dir=""

# Short and meaningful installer description, describing the app being installed.
deadbeef_description() {
  echo "DeaDBeeF (as in 0xDEADBEEF) is a modular cross-platform audio player which runs on GNU/Linux distributions, macOS, Windows, *BSD, OpenSolaris, and other UNIX-like systems"
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
deadbeef_installed() {
  if [[ -d "$DEADBEEF_INSTALL_DIR" ]]; then
    return 0
  else
    return 1
  fi
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
deadbeef_pre_install() {
  deadbeef_temp_dir=$(mktemp -d)

  echo "Generating download link..."
  local link=$(curl -s https://deadbeef.sourceforge.io/download.html | grep -m 1 "Linux x86_64" | grep ".tar.bz2" | cut -d \" -f 2)

  echo "Downloading latest deadbeef from $link"
  echo $link | wget -nv --show-progress -i - -O "$deadbeef_temp_dir/deadbeef.tar.bz2"
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
deadbeef_install() {
  echo "Extracting $deadbeef_temp_dir/deadbeef.tar.bz2 ..."
  tar --directory "$deadbeef_temp_dir" -xf "$deadbeef_temp_dir/deadbeef.tar.bz2"

  local deadbeef_folder;
  for dir in "$deadbeef_temp_dir"/deadbeef-*/; do
    if [[ -d "$dir" ]]; then
        deadbeef_folder=$dir
        break
    fi
  done

  if [[ -z "$deadbeef_folder" ]]; then
    echo "Unable to find folder named deadbeef-* inside $deadbeef_temp_dir"
    echo "Aborting installation... please download deadbeef manually from https://deadbeef.sourceforge.io/download.html"

    return 1
  fi

  local last_folder=$(basename "$deadbeef_folder")
  local latest_version=${last_folder#deadbeef-}

  if [[ -d "$DEADBEEF_INSTALL_DIR-$latest_version" ]]; then
    echo "Previous installation folder found, removing: $DEADBEEF_INSTALL_DIR-$latest_version"
    rm -r "$DEADBEEF_INSTALL_DIR-$latest_version"
  fi

  if [[ -L "$DEADBEEF_INSTALL_DIR" ]]; then
    echo "DeaDBeeF symbolic link found, removing: $DEADBEEF_INSTALL_DIR"
    rm "$DEADBEEF_INSTALL_DIR"
  fi

  echo "Copying $deadbeef_folder into $DEADBEEF_INSTALL_DIR-$latest_version"
  mkdir "$DEADBEEF_INSTALL_DIR-$latest_version" &&
    cp -r "$deadbeef_folder"/* "$DEADBEEF_INSTALL_DIR-$latest_version"

  echo "Creating symbolic link $DEADBEEF_INSTALL_DIR-$latest_version -> $DEADBEEF_INSTALL_DIR"
  ln -s -d "$DEADBEEF_INSTALL_DIR-$latest_version" "$DEADBEEF_INSTALL_DIR"
}

# Called after installation completed successfully
# Post installation may contains user interactive session
deadbeef_post_install() {
  return 0
}

# Optional to implements, this method called once all installation done
# Useful to print informational message to users
deadbeef_post_install_message() {
  cat <<EOF
Please be warned that this installer using static build version, it wasn't use package
manager, therefore it will not integrate with your system menu, please add it manually.
EOF
}

