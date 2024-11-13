#!/bin/bash

# Variables
bat_temp_folder=""

# Short and meaningful installer description, describing the app being installed.
bat_description() {
  echo "cat replacement with steroid, it will print with line number and support syntax highlighting"
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
bat_installed() {
  command -v bat 2>&1 > /dev/null
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
bat_pre_install() {
  echo "Obtaining bat latest release link..."
  link=$(curl -s https://api.github.com/repos/sharkdp/bat/releases/latest | grep "browser_download_url.*deb" | grep "bat_.*_amd64" | cut -d : -f 2,3 | tr -d \")
  
  if [[ -z $link ]]; then
    echo "Failed to retrieve bat latest release, please retry again or check download link if issue persistent"

    return 1
  fi

  bat_temp_folder=$(mktemp -d)
  echo "Downloading from: '$link' to '$bat_temp_folder/bat_latest.deb'"
  echo $link | wget -nv --show-progress -i - -O "$bat_temp_folder/bat_latest.deb"

  if [[ -f "$bat_temp_folder/bat_latest.deb" ]]; then
    echo "Download success!"

    return 0
  else
    echo "Download failed!"

    return 1
  fi
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
bat_install() {
  sudo dpkg -i "$bat_temp_folder/bat_latest.deb"

  return 0
}

# Called after installation completed successfully
# Post installation may contains user interactive session
bat_post_install() {
  rm -r $bat_temp_folder

  return 0
}

