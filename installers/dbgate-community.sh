#!/bin/bash

# Variables
dbgate_community_temp_folder=""

# Short and meaningful installer description, describing the app being installed.
dbgate-community_description() {
  echo "DbGate Community Edition - Database Management Tools, support RDBMS, NoSQL, Redis, etc... (Similar to DBeaver)"
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
dbgate-community_installed() {
  command -v dbgate 2>&1 > /dev/null
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
dbgate-community_pre_install() {
  local link="https://github.com/dbgate/dbgate/releases/latest/download/dbgate-latest.deb"

  dbgate_community_temp_folder=$(mktemp -d)
  echo "Downloading from: '$link' to '$dbgate_community_temp_folder/dbgate-latest.deb'"
  echo $link | wget -nv --show-progress -i - -O "$dbgate_community_temp_folder/dbgate-latest.deb"

  if [[ -f "$dbgate_community_temp_folder/dbgate-latest.deb" ]]; then
    echo "Download success!"

    return 0
  else
    echo "Download failed!"

    return 1
  fi
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
dbgate-community_install() {
  sudo dpkg -i "$dbgate_community_temp_folder/dbgate-latest.deb"

  return 0
}

# Called after installation completed successfully
# Post installation may contains user interactive session
dbgate-community_post_install() {
  rm -r $dbgate_community_temp_folder

  return 0
}

