#!/bin/bash

# Short and meaningful installer description, describing the app being installed.
onedriver_description() {
  echo "OneDrive Linux Client"
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
onedriver_installed() {
  command -v onedriver 2>&1 > /dev/null
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
onedriver_pre_install() {
  echo "Checking Ubuntu version..."
  local version=$(cat /etc/upstream-release/lsb-release | grep DISTRIB_RELEASE | cut -d = -f 2)
  local codename="xUbuntu_$version"

  curl -fsSL "https://download.opensuse.org/repositories/home:jstaf/$codename/Release.key" | sudo gpg --yes --dearmor --output /etc/apt/keyrings/onedriver.gpg &&
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/onedriver.gpg] http://download.opensuse.org/repositories/home:/jstaf/$codename/ /" | sudo tee /etc/apt/sources.list.d/onedriver.list &&
    sudo apt-get update
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
onedriver_install() {
  if command -v apt-fast 2>&1 > /dev/null; then
    sudo apt-fast -y install onedriver
  else
    sudo apt-get -y install onedriver
  fi
}

# Called after installation completed successfully
# Post installation may contains user interactive session
onedriver_post_install() {
  return 0
}

# Optional to implements, this method called once all installation done
# Useful to print informational message to users
onedriver_post_install_message() {
  cat <<EOF
* Be warned, this client will create a mount point after configuration, it will access your files on-demand
* Please execute man onedriver to allow mount before login
EOF
}

