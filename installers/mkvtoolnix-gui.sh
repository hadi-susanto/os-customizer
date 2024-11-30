#!/bin/bash

# Short and meaningful installer description, describing the app being installed.
mkvtoolnix-gui_description() {
  echo "MKV Toolnix GUI, edit .mkv files"
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
mkvtoolnix-gui_installed() {
  command -v mkvtoolnix-gui 2>&1 > /dev/null
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
mkvtoolnix-gui_pre_install() {
  local codename=$(cat /etc/upstream-release/lsb-release | grep DISTRIB_CODENAME | cut -d = -f 2)

  if [[ -f /etc/apt/sources.list.d/mkvtoolnix-gui.list ]]; then
    sudo rm /etc/apt/sources.list.d/mkvtoolnix-gui.list
  fi

  curl -fsSL https://mkvtoolnix.download/gpg-pub-moritzbunkus.gpg | sudo gpg --yes --dearmor --output /etc/apt/keyrings/mkvtoolnix-gui.gpg &&
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/mkvtoolnix-gui.gpg] https://mkvtoolnix.download/ubuntu/ $codename main" | sudo tee /etc/apt/sources.list.d/mkvtoolnix-gui.list &&
    sudo apt-get update
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
mkvtoolnix-gui_install() {
  if command -v apt-fast 2>&1 > /dev/null; then
    sudo apt-fast -y install mkvtoolnix mkvtoolnix-gui
  else
    sudo apt-get -y install mkvtoolnix mkvtoolnix-gui
  fi
}

# Called after installation completed successfully
# Post installation may contains user interactive session
mkvtoolnix-gui_post_install() {
  return 0
}

# Optional to implements, this method called once all installation done
# Useful to print informational message to users
mkvtoolnix-gui_post_install_message() {
  cat <<EOF
mkvmerge is part of mkvtoolnix package
EOF
}

