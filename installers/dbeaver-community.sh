#!/bin/bash

# Variables
dbeaver_community_temp_folder=""

# Short and meaningful installer description, describing the app being installed.
dbeaver-community_description() {
  echo "DBeaver Community Edition - Database Management Tools, support many database engine such as MySQL, PostgreSQL, SQLServer, etc."
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
dbeaver-community_installed() {
  command -v dbeaver-ce 2>&1 > /dev/null
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
dbeaver-community_pre_install() {
  local link="https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb"

  dbeaver_community_temp_folder=$(mktemp -d)
  echo "Downloading from: '$link' to '$dbeaver_community_temp_folder/dbeaver-ce_latest.deb'"
  echo $link | wget -nv --show-progress -i - -O "$dbeaver_community_temp_folder/dbeaver-ce_latest.deb"

  if [[ -f "$dbeaver_community_temp_folder/dbeaver-ce_latest.deb" ]]; then
    echo "Download success!"

    return 0
  else
    echo "Download failed!"

    return 1
  fi
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
dbeaver-community_install() {
  sudo dpkg -i "$dbeaver_community_temp_folder/dbeaver-ce_latest.deb"

  return 0
}

# Called after installation completed successfully
# Post installation may contains user interactive session
dbeaver-community_post_install() {
  rm -r $dbeaver_community_temp_folder

  return 0
}

