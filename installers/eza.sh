#!/bin/bash

# Short and meaningful installer description, describing the app being installed.
eza_description() {
  echo "eza a an ls supercharged! it have better presentation"
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
eza_installed() {
  command -v eza 2>&1 > /dev/null
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
eza_pre_install() {
  curl -fsSL https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --yes --dearmor --output /etc/apt/keyrings/eza-gierens.gpg &&
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/eza-gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/eza-gierens.list &&
    sudo apt-get update
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
eza_install() {
  if command -v apt-fast 2>&1 > /dev/null; then
    sudo apt-fast -y install eza
  else
    sudo apt-get -y install eza
  fi
}

# Called after installation completed successfully
# Post installation may contains user interactive session
eza_post_install() {
  return 0
}

