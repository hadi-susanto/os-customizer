#!/bin/bash

# Variables
mongodb_compass_temp_folder=""

# Short and meaningful installer description, describing the app being installed.
mongodb-compass_description() {
  echo "MongoDB GUI tools, this is official tools from MongoDB creator"
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
mongodb-compass_installed() {
  command -v mongodb-compass 2>&1 > /dev/null
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
mongodb-compass_pre_install() {
  echo "Obtaining bat latest release link..."
  local link=$(curl -s https://api.github.com/repos/mongodb-js/compass/releases/latest | grep "browser_download_url.*deb" | grep "mongodb-compass_.*_amd64" -m 1 | cut -d : -f 2,3 | tr -d \")
  
  if [[ -z $link ]]; then
    echo "Failed to retrieve mongodb-compass latest release, please retry again or check download link if issue persistent"

    return 1
  fi

  mongodb_compass_temp_folder=$(mktemp -d)
  echo "Downloading from: '$link' to '$mongodb_compass_temp_folder/mongodb-compass_latest.deb'"
  echo $link | wget -nv --show-progress -i - -O "$mongodb_compass_temp_folder/mongodb-compass_latest.deb"

  if [[ -f "$mongodb_compass_temp_folder/mongodb-compass_latest.deb" ]]; then
    echo "Download success!"

    return 0
  else
    echo "Download failed!"

    return 1
  fi
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
mongodb-compass_install() {
  sudo dpkg -i "$mongodb_compass_temp_folder/mongodb-compass_latest.deb"

  return 0
}

# Called after installation completed successfully
# Post installation may contains user interactive session
mongodb-compass_post_install() {
  rm -r $mongodb_compass_temp_folder
}

